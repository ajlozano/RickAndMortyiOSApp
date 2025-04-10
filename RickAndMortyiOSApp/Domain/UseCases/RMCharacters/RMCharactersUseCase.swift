//
//  RMCharactersUseCase.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

// MARK: RMCharactersUseCase - Protocol

protocol RMCharactersUseCase {
    
    /// Method that fetch the characters basen on a input parameters.
    /// - Parameter params: Input parameters for fetch the characters list.
    /// - Parameter completion: Returns a characters list Entity or an error.
    func execute(params: RMCharactersUseCaseParameters) async throws -> RMCharactersListEntity
    
    
    /// Method to clean the stored current filter parameters for the fetch query.
    func clearFilters()
}

// MARK: DefaultRMCharactersUseCase Class

final class DefaultRMCharactersUseCase: RMCharactersUseCase {
    
    private var repository: RMCharactersRepository
    private var paginationUrl: String?
    private var hasFetchAllCharacters: Bool = false
    
    init(repository: RMCharactersRepository) {
        self.repository = repository
    }
}

// MARK: DefaultRMCharactersUseCase - Execute

extension DefaultRMCharactersUseCase {
    
    func execute(params: RMCharactersUseCaseParameters) async throws -> RMCharactersListEntity {
        
        let repositoryParams = RMCharactersRepositoryParameters(paginationUrl: paginationUrl, searchFilter: params.searchFilter, charactersIDs: params.charactersIDs)
        let decodable = try await repository.getCharacters(params: repositoryParams)
        
        let entity = RMCharactersListEntity(decodable: decodable)

        if let nextPaginationUrl = entity.info?.next {
            paginationUrl = nextPaginationUrl
        } else {
            hasFetchAllCharacters = true
        }
        
        return entity
    }
}

// MARK: DefaultRMCharactersUseCase - Manage Filters

extension DefaultRMCharactersUseCase {
    
    func clearFilters() {
        self.paginationUrl = nil
    }
}
