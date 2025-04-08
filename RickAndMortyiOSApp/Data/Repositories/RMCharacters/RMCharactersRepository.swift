//
//  RMCharactersRepository.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

// MARK: RMCharactersRepository Protocol

protocol RMCharactersRepository {
    
    /// Method that fetch the characters list
    /// - Parameter params: Input parameters for fetch the characters list.
    /// - Returns: Returns a characters list Decodable or throw an error.
    func getCharacters(params: RMCharactersRepositoryParameters) async throws -> RMCharactersListDecodable
}

// MARK: DefaultRMCharactersRepository Class

final class DefaultRMCharactersRepository: RMCharactersRepository {
        
    func getCharacters(params: RMCharactersRepositoryParameters) async throws -> RMCharactersListDecodable {
        
        let endpoint = params.paginationUrl ?? RMEndpoints.generateURLWithParams(for: .character, searchFilter: params.searchFilter, charactersFilter: params.charactersIDs)
                        
        guard let url = URL(string: endpoint) else {
            let error: RMError = .serviceError(message: "Malformed URL for getTransactions in RMCharactersRepository")
            throw error
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let responsestatus = (response as? HTTPURLResponse)?.statusCode, responsestatus != 200 {
            throw RMError.serviceError(message: "Error when when fetching in RMCharactersRepository")
        }
        
        guard let decodable = try? JSONDecoder().decode(RMCharactersListDecodable.self, from: data) else {
            throw RMError.decodeError(forDecodable: "RMCharactersListDecodable")
        }
        
        return decodable
    }
}
