//
//  ContentView.swift
//  RickAndMorty
//
//  Created by RGMCode on 08.06.24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var raMViewModel = RaMViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(raMViewModel.characters) { character in
                    NavigationLink(destination: RaMDetailView(raMModel: .constant(character))) {
                        HStack {
                            AsyncImage(url: URL(string: character.image)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            .cornerRadius(15)

                            VStack(alignment: .leading) {
                                Text(character.name)
                                    .font(.title)
                            }
                        }
                    }
                }
                if raMViewModel.canLoadMorePages {
                    ProgressView()
                        .onAppear {
                            raMViewModel.fetchCharacters()
                        }
                }
            }
            .navigationTitle("Rick and Morty Characters")
        }
        .onAppear {
            raMViewModel.fetchCharacters()
        }
    }
}

#Preview {
    ContentView().environmentObject(RaMViewModel())
}
