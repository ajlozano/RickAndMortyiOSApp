//
//  CharacterRepository.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import Foundation

protocol RMRepository {
    func fetchAllCharacters(_ request: RMRequest) async throws -> CharacterList
}
