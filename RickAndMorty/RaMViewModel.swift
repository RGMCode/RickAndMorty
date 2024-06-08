//
//  RaMViewModel.swift
//  RickAndMorty
//
//  Created by RGMCode on 08.06.24.
//

import Foundation
import Combine

class RaMViewModel: ObservableObject {
    @Published var characters: [RaMModel] = []
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    var canLoadMorePages = true

    func fetchCharacters() {
        guard canLoadMorePages else { return }

        guard let url = URL(string: "https://rickandmortyapi.com/api/character?page=\(currentPage)") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CharacterResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching characters: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { response in
                self.characters.append(contentsOf: response.results.map { character in
                    RaMModel(
                        name: character.name,
                        status: character.status,
                        species: character.species,
                        gender: character.gender,
                        image: character.image,
                        origin: Location(name: character.origin.name, url: character.origin.url),
                        location: Location(name: character.location.name, url: character.location.url)
                    )
                })
                self.currentPage += 1
                self.canLoadMorePages = !response.results.isEmpty
            })
            .store(in: &cancellables)
    }
}
