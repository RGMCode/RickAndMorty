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
            ZStack {
                Color.teal.edgesIgnoringSafeArea(.all)
                List {
                    ForEach(raMViewModel.characters, id: \.id) { character in
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
                                        .foregroundColor(.white)
                                }
                            }
                        }.listRowBackground(Color.teal)
                    }
                    if raMViewModel.canLoadMorePages {
                        ProgressView()
                            .onAppear {
                                raMViewModel.fetchCharacters()
                            }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationBarTitleDisplayMode(.inline)
                 .toolbar {
                          ToolbarItem(placement: .principal) {
                              Text("Rick and Morty Char's")
                              .foregroundColor(.white)
                              .font(.largeTitle)
                                }
                            }
    
            }
            .onAppear {
                print("ContentView appeared, fetching characters")
                raMViewModel.fetchCharacters()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(RaMViewModel())
}
