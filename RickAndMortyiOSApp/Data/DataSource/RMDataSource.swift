//
//  DataSource.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import Foundation

protocol RMDataSource {
    func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type) async throws -> T
}
