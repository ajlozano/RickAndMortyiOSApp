//
//  RMRequestInfoDecodable.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

struct RMRequestInfoDecodable: Codable {
    var count: Int?
    var pages: Int?
    var next: String?
    var previous: String?

    enum CodingKeys: String, CodingKey {
        case count, pages, next
        case previous = "prev"
    }
}
