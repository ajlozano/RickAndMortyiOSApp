//
//  AppDependenciesBuilder.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 7/4/25.
//

import Foundation

struct AppDependenciesBuilder {
    static func build() -> AppDependencies {
        let characterRepository = CharactersRepositoryImpl()
        let imageService = ImageServiceImpl()

        return AppDependencies(
            fetchAllCharactersUseCase: FetchAllCharactersUseCaseImpl(repository: characterRepository),
            imageService: imageService
        )
    }
}
