//
//  RMRequest.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import Foundation

/// Object that represents a single API call
final class RMRequest {
    // MARK: - Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }

    // MARK: - Properties

    let endpoint: RMEndpoint
    private let pathComponents: [String]
    private let queryParameters: [URLQueryItem]

    public var httpMethod: String { "GET" }

    /// Constructed URL string
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue

        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }

        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")

            string += argumentString
        }

        return string
    }

    /// Final URL for the API request
    public var url: URL? {
        URL(string: urlString)
    }

    // MARK: - Init

    init(
        endpoint: RMEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }

    /// Failable initializer to reverse-engineer a request from a full URL
    convenience init?(url: URL) {
        let string = url.absoluteString

        guard string.contains(Constants.baseUrl) else { return nil }

        let trimmed = string.replacingOccurrences(of: Constants.baseUrl + "/", with: "")
        let urlComponents = trimmed.components(separatedBy: "?")
        let pathPart = urlComponents[0]
        let queryPart = urlComponents.count > 1 ? urlComponents[1] : nil

        let pathComponents = pathPart.components(separatedBy: "/")
        guard let endpointRaw = pathComponents.first,
              let endpoint = RMEndpoint(rawValue: endpointRaw) else {
            return nil
        }

        var remainingPath = pathComponents
        remainingPath.removeFirst()

        let queryItems: [URLQueryItem] = queryPart?
            .components(separatedBy: "&")
            .compactMap { pair in
                let parts = pair.components(separatedBy: "=")
                guard parts.count == 2 else { return nil }
                return URLQueryItem(name: parts[0], value: parts[1])
            } ?? []

        self.init(endpoint: endpoint, pathComponents: remainingPath, queryParameters: queryItems)
    }
}

// MARK: - Convenience

extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
    static let listEpisodesRequest = RMRequest(endpoint: .episode)
    static let listLocationsRequest = RMRequest(endpoint: .location)
}
