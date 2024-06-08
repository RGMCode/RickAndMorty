//
//  RaMModel.swift
//  RickAndMorty
//
//  Created by RGMCode on 08.06.24.
//

import SwiftUI
import Foundation

struct Location: Codable {
    let name: String
    let url: String
}

struct RaMModel: Codable, Identifiable {
    let id = UUID()
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let origin: Location
    let location: Location
}
       
struct CharacterResponse: Codable {
    let results: [RaMModel]
}
