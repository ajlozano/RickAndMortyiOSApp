//
//  RMEpisodesRepositoryFullSuccessMock.swift
//  RickAndMortyiOSAppTests
//
//  Created by Toni Lozano Fernández on 10/4/25.
//

import XCTest
@testable import RickAndMortyiOSApp

final class RMEpisodesRepositoryFullSuccessMock: RMEpisodesRepository {
    func getEpisodes(params: RMEpisodesRepositoryParameters) async throws -> RMEpisodesListDecodable {
        let json = RMEpisodesListMock.makeFullJsonMock()
        guard let decodable = try? JSONDecoder().decode(RMEpisodesListDecodable.self, from: json) else {
            throw RMError.decodeError(forDecodable: "Mock decodable Error")
        }
        return decodable
    }
}
