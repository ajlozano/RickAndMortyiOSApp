//
//  APIService.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import Foundation

protocol RMDataSource {
    func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type) async throws -> T
}

/// Primary API service object to get Rick and Morty data
final class RMAPIService: RMDataSource {
//    private let cacheManager = RMAPICacheManager()

    /// Error types
    enum APIError: Error {
        case failedToCreateRequest
        case failedToGetData
    }

    /// Send Rick and Morty API Call using async/await
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    /// - Returns: Decoded object of expected type
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type) async throws -> T {
        guard let urlRequest = self.request(from: request) else {
            throw APIError.failedToCreateRequest
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.failedToGetData
            }
            
            let result = try JSONDecoder().decode(type.self, from: data)

            return result
        } catch {
            throw error
        }
    }

    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
