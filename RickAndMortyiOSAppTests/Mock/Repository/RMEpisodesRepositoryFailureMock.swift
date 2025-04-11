//
//  RMEpisodesRepositoryFailure+Mock.swift
//  RickAndMortyiOSAppTests
//
//  Created by Toni Lozano Fernández on 10/4/25.
//

import XCTest
@testable import RickAndMortyiOSApp

final class RMEpisodesRepositoryFailureMock: RMEpisodesRepository {
    func getEpisodes(params: RMEpisodesRepositoryParameters) async throws -> RMEpisodesListDecodable {
        throw RMError.serviceError(message: "Error when when fetching in RMEpisodesRepositoryFailureMock")
    }
}
