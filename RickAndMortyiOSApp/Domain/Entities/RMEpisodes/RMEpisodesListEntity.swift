//
//  RMEpisodesListEntity.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

struct RMEpisodesListEntity {
    var info: RMRequestInfoEntity?
    var results: [RMEpisodeEntity]?
    
    init(decodable: RMEpisodesListDecodable) {
        if let decodableInfo = decodable.info {
            self.info = RMRequestInfoEntity(decodable: decodableInfo)
        }
        self.results = decodable.results?.map({ resultsDecodable in
            RMEpisodeEntity(decodable: resultsDecodable)
        })
    }
}
