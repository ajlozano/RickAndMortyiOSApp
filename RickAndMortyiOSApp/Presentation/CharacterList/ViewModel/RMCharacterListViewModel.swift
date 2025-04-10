//
//  CharacterListViewModel.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI

@MainActor
final class RMCharacterListViewModel: ObservableObject {
    @Published var model: RMCharactersListModel = RMCharactersListModel()
    @Published var showEmptyStateError: Bool = false
    @Published var loadingStatus: RMLoadingStatus = .stop
    @Published var isLoadingMoreCharacters = false
    @Published var isInitialLoading = true
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    let charactersUseCase: RMCharactersUseCase
    
    init(charactersListUseCase: RMCharactersUseCase) {
        self.charactersUseCase = charactersListUseCase
        
        fetchData(withSearchFilter: nil)
    }
    
    func fetchData(withSearchFilter searchFilter: String?) {
        
        loadingStatus = .start
        let useCaseParameters = RMCharactersUseCaseParameters(searchFilter: searchFilter)
        Task {
            do {
                let result = try await charactersUseCase.execute(params: useCaseParameters)
                loadingStatus = .stop
                createModel(for: result)
            } catch {
                loadingStatus = .stop
                createEmptyStateModel(forError: error)
            }
        }
    }
    
    func fetchMoreDataIfNeeded(currentCharacter: RMCharacterEntity) {
        if loadingStatus == .start { return }
        
        let thresholdIndex = model.characters.index(model.characters.endIndex, offsetBy: -1)
        if model.characters.firstIndex(where: { $0.id == currentCharacter.id }) == thresholdIndex {
            self.fetchData(withSearchFilter: nil)
        }
    }
}

// MARK: Mannage Output Models

extension RMCharacterListViewModel {
    
    /// This method inflates a model of the view for data binding with the viewController
    /// - Parameter entity: Entity model result of the Characters request.
    func createModel(for entity: RMCharactersListEntity) {
        guard let newCharacters = entity.results else {
            let error = RMError.unknownError(message: "Could not get list of characters in RMCharactersSelectorViewModel")
            createEmptyStateModel(forError: error)
            return
        }
        
        let currentCharacters = model.characters
        let isFetchDataFinished: Bool = entity.info?.next == nil
        showEmptyStateError = false
        model.characters = currentCharacters + newCharacters
        model.isFetchDataFinished = isFetchDataFinished
    }
    
    /// This method inflates an error model for data binding with the viewController
    /// - Parameter error: Value of the error occurred
    func createEmptyStateModel(forError: Error) {
        model = RMCharactersListModel(characters: [], isFetchDataFinished: true)
        showEmptyStateError = true
    }
}
