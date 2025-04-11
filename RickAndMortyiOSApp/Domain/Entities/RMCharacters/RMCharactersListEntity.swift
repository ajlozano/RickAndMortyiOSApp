//
//  RMCharactersListEntity.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

struct RMCharactersListEntity {
    var info: RMRequestInfoEntity?
    var results: [RMCharacterEntity]?
    
    init(decodable: RMCharactersListDecodable) {
        if let decodableInfo = decodable.info {
            self.info = RMRequestInfoEntity(decodable: decodableInfo)
        }
        self.results = decodable.results?.map({ characterDecodable in
            RMCharacterEntity(decodable: characterDecodable)
        })
    }
    
    init(info: RMRequestInfoEntity? = nil, results: [RMCharacterEntity] = []) {
        self.info = info
        self.results = results
    }
}
