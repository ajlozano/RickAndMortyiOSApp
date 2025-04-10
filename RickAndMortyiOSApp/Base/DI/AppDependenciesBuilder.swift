//
//  AppDependenciesBuilder.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 7/4/25.
//

import Foundation

struct AppDependenciesBuilder {
    static func build() -> AppDependencies {
        let charactersRepository = DefaultRMCharactersRepository()
        let episodesRepository = DefaultRMEpisodesRepository()

        return AppDependencies(
            charactersUseCase: DefaultRMCharactersUseCase(repository: charactersRepository),
            episodesUseCase: DefaultRMEpisodesUseCase(repository: episodesRepository)
        )
    }
}
