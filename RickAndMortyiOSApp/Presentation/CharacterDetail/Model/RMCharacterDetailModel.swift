//
//  RMCharacterDetailModel.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 9/4/25.
//

import Foundation

struct RMCharacterDetailModel {
    var imagePath: String
    var status: RMCharacterStatusEntity
    var gender: String
    var species: String
    var origin: String
    var location: String
    var episodes: [RMEpisodeEntity]
}
