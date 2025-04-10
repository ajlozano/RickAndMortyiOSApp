//
//  RMCharacterDetailModel.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 9/4/25.
//

import UIKit

struct RMCharacterDetailModel {
    var name: String
    var imagePath: String?
    var image: UIImage?
    var status: RMCharacterStatusEntity
    var gender: String
    var species: String
    var origin: String
    var location: String
    var episodes: [RMEpisodeEntity]
    
    init(name: String = "", imagePath: String? = nil, image: UIImage? = nil, status: RMCharacterStatusEntity = .Unknown, gender: String = "", species: String = "", origin: String = "", location: String = "", episodes: [RMEpisodeEntity] = []) {
        self.name = name
        self.imagePath = imagePath
        self.status = status
        self.gender = gender
        self.species = species
        self.origin = origin
        self.location = location
        self.episodes = episodes
    }
}
