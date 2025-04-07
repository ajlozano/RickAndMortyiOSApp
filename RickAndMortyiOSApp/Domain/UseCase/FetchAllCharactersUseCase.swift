//
//  FetchCharactersUseCase.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import Foundation

protocol FetchAllCharactersUseCase {
    func execute(_ request: RMRequest) async throws -> CharacterList
}

final class FetchAllCharactersUseCaseImpl: FetchAllCharactersUseCase {
    private let repository: CharactersRepository

    init(repository: CharactersRepository) {
        self.repository = repository
    }
    
    func execute(_ request: RMRequest) async throws -> CharacterList {
        try await repository.fetchAllCharacters(request)
    }
}
