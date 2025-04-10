//
//  RMCharacterLocationEntity.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

struct RMCharacterLocationEntity: Equatable, Hashable {
    var name: String?
    var url: String?
    
    init(decodable: RMCharacterLocationDecodable) {
        self.name = decodable.name
        self.url = decodable.url
    }
}
