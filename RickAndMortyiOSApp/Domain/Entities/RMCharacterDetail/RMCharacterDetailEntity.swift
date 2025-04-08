//
//  RMCharacterDetailEntity.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

struct RMCharacterDetailEntity {
    var episodes: [RMEpisodeEntity]?
    
    init(episodesEntity: RMEpisodesListEntity) {
        self.episodes = episodesEntity.results
    }
}
