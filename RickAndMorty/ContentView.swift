//
//  ContentView.swift
//  RickAndMorty
//
//  Created by RGMCode on 08.06.24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = RaMViewModel()
    
    var body: some View {
                NavigationView {
                    List(viewModel.characters) { character in
                        HStack {
                            AsyncImage(url: URL(string: character.image)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            VStack(alignment: .leading) {
                                Text(character.name)
                                    .font(.title2)
                                    .bold()
                                    Text("Species: \(character.species)")
                                        .font(.title3)
                                    Text("Gender: \(character.gender)")
                                        .font(.title3)
                                    Text("Status: \(character.status)")
                                        .font(.title3)
                            }
                        }
                    }
                    .navigationTitle("Rick and Morty Char`s")
                }
                .onAppear {
                    viewModel.fetchCharacters()
                }
    }
}

#Preview {
    ContentView()
}
