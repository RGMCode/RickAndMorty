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
        
        // Abrufen von Charakteren von der API
        func fetchCharacters() {
            // URL der Rick and Morty API
            guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
            
            // Datenverarbeitung mit Combine und URLSession
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
                    // Aktualisieren des published Array mit den Ergebnissen
                    self.characters = response.results
                })
                .store(in: &cancellables)
        }
    
}
