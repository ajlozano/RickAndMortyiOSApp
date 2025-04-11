//
//  RMCharactersRepositoryFailure+Mock.swift
//  RickAndMortyiOSAppTests
//
//  Created by Toni Lozano Fernández on 10/4/25.
//

import XCTest
@testable import RickAndMortyiOSApp

final class RMCharactersRepositoryFailureMock: RMCharactersRepository {
    func getCharacters(params: RMCharactersRepositoryParameters) async throws -> RMCharactersListDecodable {
        throw RMError.serviceError(message: "Error when when fetching in RMCharactersRepositoryFailureMock")
    }
}
