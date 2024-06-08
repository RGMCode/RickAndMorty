//
//  RaMDetailView.swift
//  RickAndMorty
//
//  Created by RGMCode on 08.06.24.
//

import SwiftUI

struct RaMDetailView: View {
    @Binding var raMModel: RaMModel
    @EnvironmentObject var raMViewModel: RaMViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: raMModel.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 370, height: 370)
            .cornerRadius(30)
            .overlay(
                     RoundedRectangle(cornerRadius: 15)
                     .stroke(
                             LinearGradient(
                                gradient: Gradient(colors: [.purple, .blue, .teal]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                             ),
                             lineWidth: 15)
            )
            .padding()
            
            Text(raMModel.name)
                .font(.system(size: 50))
                .fontWeight(.bold)
            Text("Species: \(raMModel.species)")
                .font(.title2)
            Text("Status: \(raMModel.status)")
                .font(.title2)
            Text("Gender: \(raMModel.gender)")
                .font(.title2)
            Text("Origin: \(raMModel.origin.name)")
                .font(.title2)
            Text("Location: \(raMModel.location.name)")
                .font(.title2)
            
            Spacer()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "arrow.uturn.backward.square.fill")
                    .font(.system(size: 45))
                    .foregroundColor(.teal)
            }
            .padding()
        }
        .navigationTitle("Character Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RaMDetailView(raMModel: .constant(RaMModel(
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        gender: "Male",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        origin: Location(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"),
        location: Location(name: "Earth", url: "https://rickandmortyapi.com/api/location/20")
    )))
    .environmentObject(RaMViewModel())
}
