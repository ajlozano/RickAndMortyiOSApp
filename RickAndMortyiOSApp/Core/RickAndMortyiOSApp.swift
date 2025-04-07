//
//  RickAndMortyiOSAppApp.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 5/4/25.
//

import SwiftUI

@main
struct RickAndMortyiOSAppApp: App {
    var body: some Scene {
        WindowGroup {
            let dependencies = AppDependenciesBuilder.build()
                        
            CharacterListView(
                viewModel: CharacterListViewModel(
                    useCase: dependencies.fetchAllCharactersUseCase,
                    imageService: dependencies.imageService
                )
            )
            .environment(\.appDependencies, dependencies)
        }
    }
}
