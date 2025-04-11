//
//  RMEpisodesRepository.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

// MARK: RMEpisodesRepository Protocol

protocol RMEpisodesRepository {
    /// Method that fetch the episodes list
    /// - Parameter params: Input parameters for fetch the episodes list.
    /// - Returns: Returns a episodes list Decodable or throw an error.
    func getEpisodes(params: RMEpisodesRepositoryParameters) async throws -> RMEpisodesListDecodable
}

// MARK: DefaultRMEpisodesRepository Class

final class DefaultRMEpisodesRepository: RMEpisodesRepository {
    func getEpisodes(params: RMEpisodesRepositoryParameters) async throws -> RMEpisodesListDecodable {
        let endpoint = params.paginationUrl ?? RMEndpoints.generateURLWithParams(for: .episode, episodesFilter: params.episodeIDs)
        
        guard let url = URL(string: endpoint) else {
            throw RMError.serviceError(message: "Malformed URL for getTransactions in RMEpisodesRepository")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let responsestatus = (response as? HTTPURLResponse)?.statusCode, responsestatus != 200 {
            throw RMError.serviceError(message: "Error when when fetching in RMEpisodesRepository")
        }
        
        guard let decodable = try? JSONDecoder().decode(RMEpisodesListDecodable.self, from: data) else {
            throw RMError.decodeError(forDecodable: "RMEpisodesListDecodable")
        }
        
        return decodable
    }
}
