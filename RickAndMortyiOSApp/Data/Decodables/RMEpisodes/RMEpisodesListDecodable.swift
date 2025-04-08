//
//  RMEpisodesListDecodable.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

struct RMEpisodesListDecodable: Codable {
    var info: RMRequestInfoDecodable?
    var results: [RMEpisodeDecodable]?
    
    enum ConfigKeys: String, CodingKey {
        case info
        case results
    }
    
    /// Inicializer from decoder depending if we are filtering the request with a episodes list or not.
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.info = try values.decode(RMRequestInfoDecodable.self, forKey: .info)
            self.results = try values.decode([RMEpisodeDecodable].self, forKey: .results)
            return
        } catch {
            let container = try decoder.singleValueContainer()
            results = try container.decode([RMEpisodeDecodable].self)
            return
        }
    }
}
