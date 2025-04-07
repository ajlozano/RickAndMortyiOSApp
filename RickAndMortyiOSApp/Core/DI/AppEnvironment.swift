//
//  AppDependencies.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 7/4/25.
//

import SwiftUI

struct AppDependencies {
    let fetchAllCharactersUseCase: FetchAllCharactersUseCase
    let imageService: ImageService
}

private struct AppDependenciesKey: EnvironmentKey {
    static let defaultValue = AppDependenciesBuilder.build()
}

extension EnvironmentValues {
    var appDependencies: AppDependencies {
        get { self[AppDependenciesKey.self] }
        set { self[AppDependenciesKey.self] = newValue }
    }
}
