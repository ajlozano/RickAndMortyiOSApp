//
//  RMCharacter.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import Foundation

struct Character: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: CharacterGender
    let origin: Origin
    let location: SingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
