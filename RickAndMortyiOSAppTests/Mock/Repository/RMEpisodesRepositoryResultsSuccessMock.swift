//
//  RMEpisodesRepositoryResultsSuccess+Mock.swift
//  RickAndMortyiOSAppTests
//
//  Created by Toni Lozano Fernández on 10/4/25.
//

import XCTest
@testable import RickAndMortyiOSApp

final class RMEpisodesRepositoryResultsSuccessMock: RMEpisodesRepository {
    func getEpisodes(params: RMEpisodesRepositoryParameters) async throws -> RMEpisodesListDecodable {
        let json = RMEpisodesListMock.makeResultsJsonMock()
        guard let decodable = try? JSONDecoder().decode(RMEpisodesListDecodable.self, from: json) else {
            throw RMError.decodeError(forDecodable: "Mock decodable error")
        }
        return decodable
    }
}
