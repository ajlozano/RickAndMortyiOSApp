//
//  RMCharacterDecodable.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

struct RMCharacterDecodable: Codable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: RMCharacterLocationDecodable?
    var location: RMCharacterLocationDecodable?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
}
