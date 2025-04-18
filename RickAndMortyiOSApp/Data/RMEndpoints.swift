//
//  RMEndpoints.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

/// Enpoints enumeration for get RM API data
/// - character: endpoint to retrieve all the data of the characters
/// - episode: endpoint to retrieve all the data of the episodes
enum RMEndpoint: String {
    case character
    case episode
}

// MARK: RMEndpoints

struct RMEndpoints {
    static let baseURL = "https://rickandmortyapi.com/api/"
    
    /// characters Key Filters
    static let pageKey = "/?page=%d"
    static let nameKey = "?name=%@"
    static let charactersKey = "/%@"
    static let locationsKey = "/%@"
    static let episodesKey = "/,%@"
}

// MARK: Generate URL Formatted

extension RMEndpoints {
    /// this method generates a valid endpoint string with the necesary paramas formatted
    /// - Parameters:
    ///   - endpoint: The tyoe of the request acording to RMEndpoint.
    ///   - searchFilter: String representation of the input query to filter characters.
    ///   - charactersFilter: Array of Strings containing the characters IDs for we want to filter the characters request.
    ///   - locationsFilter: Array of Strings containing the locations IDs for we want to filter the locations request.
    ///   - episodesFilter: Array of Strings containing the episodes IDs for we want to filter the episodes request.
    /// - Returns: Valid endpoint string with the necesary paramas formatted
    static func generateURLWithParams(for endpoint: RMEndpoint,
                                      searchFilter: String? = nil,
                                      charactersFilter: [String]? = nil,
                                      locationsFilter: [String]? = nil,
                                      episodesFilter: [String]? = nil) -> String {
        
        var url = self.baseURL + endpoint.rawValue
        
        if let searchFilter = searchFilter {
            url += String(format: nameKey, searchFilter)
        }
        
        if let charactersFilter = charactersFilter {
            let characters = charactersFilter.joined(separator: ",")
            url += String(format: charactersKey, characters)
        }
        
        if let locationsFilter = locationsFilter {
            let locations = locationsFilter.joined(separator: ",")
            url += String(format: locationsKey, locations)
        }
        
        if let episodesFilter = episodesFilter {
            let episodes = episodesFilter.joined(separator: ",")
            url += String(format: episodesKey, episodes)
        }
        
        return url
    }
}
