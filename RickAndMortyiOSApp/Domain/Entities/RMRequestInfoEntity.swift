//
//  RMRequestInfoEntity.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

struct RMRequestInfoEntity {
    var count: Int?
    var pages: Int?
    var next: String?
    var previous: String?

    init(decodable: RMRequestInfoDecodable) {
        self.count = decodable.count
        self.pages = decodable.pages
        self.next = decodable.next
        self.previous = decodable.previous
    }
}
