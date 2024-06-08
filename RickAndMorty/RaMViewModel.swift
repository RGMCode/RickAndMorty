//
//  RaMViewModel.swift
//  RickAndMorty
//
//  Created by RGMCode on 08.06.24.
//

import SwiftUI
import Foundation
import Combine

class RaMViewModel: ObservableObject {
    
        @Published var characters: [Character] = []
        private var cancellables = Set<AnyCancellable>()
        
        func fetchCharacters() {
            guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
            
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
                    self.characters = response.results
                })
                .store(in: &cancellables)
        }
    
}
