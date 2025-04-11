//
//  RMEpisodesUseCase.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

// MARK: RMEpisodesUseCase - Protocol

protocol RMEpisodesUseCase {
    
    /// Method that fetch the episodes basen on a input parameters.
    /// - Parameter params: Input parameters for fetch the episodes list.
    /// - Returns: Returns a episodes list Entity or throw an error.
    func execute(params: RMEpisodesUseCaseParameters) async throws -> RMEpisodesListEntity
}

// MARK: DefaultRMCharactersUseCase Class

final class DefaultRMEpisodesUseCase: RMEpisodesUseCase {
    private var repository: RMEpisodesRepository
    private var paginationUrl: String?
    private var hasFetchAllEpisodes: Bool = false
    
    init(repository: RMEpisodesRepository) {
        self.repository = repository
    }
}

// MARK: DefaultRMEpisodesUseCase - Execute

extension DefaultRMEpisodesUseCase {
    
    func execute(params: RMEpisodesUseCaseParameters) async throws -> RMEpisodesListEntity {
        let repositoryParams = RMEpisodesRepositoryParameters(paginationUrl: paginationUrl, episodeIDs: params.episodesIDs)
        let decodable = try await repository.getEpisodes(params: repositoryParams)

        let entity = RMEpisodesListEntity(decodable: decodable)
        if let nextPaginationUrl = entity.info?.next {
            paginationUrl = nextPaginationUrl
        } else {
            hasFetchAllEpisodes = true
        }
        
        return entity
    }
}
