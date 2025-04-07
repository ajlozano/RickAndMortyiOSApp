//
//  FetchCharactersUseCase.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import Foundation

protocol FetchAllCharacters {
    func execute(_ request: RMRequest) async throws -> CharacterList
}

final class FetchAllCharactersUseCase: FetchAllCharacters {
    private let repository: RMRepository

    init(repository: RMRepository) {
        self.repository = repository
    }
    
    func execute(_ request: RMRequest) async throws -> CharacterList {
        try await repository.fetchAllCharacters(request)
    }
}
