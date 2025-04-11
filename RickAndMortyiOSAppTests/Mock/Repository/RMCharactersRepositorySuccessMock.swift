//
//  RMCharactersRepositorySuccess+Mock.swift
//  RickAndMortyiOSAppTests
//
//  Created by Toni Lozano Fernández on 10/4/25.
//

import XCTest
@testable import RickAndMortyiOSApp

final class RMCharactersRepositorySuccessMock: RMCharactersRepository {
    func getCharacters(params: RMCharactersRepositoryParameters) async throws -> RMCharactersListDecodable {
        let json = RMCharactersListMock.makeJsonMock()
        guard let decodable = try? JSONDecoder().decode(RMCharactersListDecodable.self, from: json) else {
            throw RMError.decodeError(forDecodable: "Mock decodable Error")
        }
        return decodable
    }
}
