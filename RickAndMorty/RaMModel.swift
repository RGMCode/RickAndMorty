//
//  RaMModel.swift
//  RickAndMorty
//
//  Created by RGMCode on 08.06.24.
//

import SwiftUI
import Foundation

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}
       
struct CharacterResponse: Codable {
    let results: [Character]
}
