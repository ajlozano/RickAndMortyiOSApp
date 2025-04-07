//
//  CharacterRepositoryImpl.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import Foundation

protocol CharactersRepository {
    func fetchAllCharacters(_ request: RMRequest) async throws -> CharacterList
}

final class CharactersRepositoryImpl: CharactersRepository {
    private let service: RMAPIService = RMAPIService()

    func fetchAllCharacters(_ request: RMRequest) async throws -> CharacterList {
        let response = try await service.execute(request, expecting: GetAllCharactersResponse.self)
        return response.mapResponse()
    }
}
