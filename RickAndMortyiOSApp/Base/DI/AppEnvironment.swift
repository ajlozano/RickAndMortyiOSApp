//
//  AppDependencies.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 7/4/25.
//

import SwiftUI

// MARK: AppDependencies struct

struct AppDependencies {
    let charactersUseCase: RMCharactersUseCase
    let episodesUseCase: RMEpisodesUseCase
}

// MARK: AppDependencies default key

private struct AppDependenciesKey: EnvironmentKey {
    static let defaultValue = AppDependenciesBuilder.build()
}

// MARK: AppDependencies key values

extension EnvironmentValues {
    var appDependencies: AppDependencies {
        get { self[AppDependenciesKey.self] }
        set { self[AppDependenciesKey.self] = newValue }
    }
}
