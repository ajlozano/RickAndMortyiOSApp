//
//  CharacterListViewModel.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import Foundation

@MainActor
final class CharacterListViewModel: ObservableObject {
    @Published var errorManager: ErrorManager = ErrorManager()
    @Published var characters: [Character] = []
    @Published var apiInfo: CharacterList.Info? = nil
    @Published var isLoadingMoreCharacters = false
    @Published var isInitialLoading = true

    private let fetchAllCharactersUseCase: FetchAllCharacters = FetchAllCharactersUseCase(repository: RMRepositoryImpl())

    private var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    /// Fetch initial set of characters (20)
    func fetchCharacters() {
        Task {
            do {
                let result = try await fetchAllCharactersUseCase.execute(.listCharactersRequest)
                characters = result.characters
                apiInfo = result.info
                errorManager.clearError()
                isInitialLoading = false
            } catch {
                print(error.localizedDescription)
                errorManager.showError(error.localizedDescription)
                isInitialLoading = false
            }
        }
    }
    
    /// Check if paginate more character is needed
    func loadMoreCharactersIfNeeded(currentCharacter: Character) {
        guard !isLoadingMoreCharacters,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -1)
        if characters.firstIndex(where: { $0.id == currentCharacter.id }) == thresholdIndex {
            self.fetchAdditionalCharacters(url: url)
        }
    }
    
    /// Paginate if additional characters are needed
    private func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacters = false
            return
        }
        
        Task {
            do {
                let result = try await fetchAllCharactersUseCase.execute(request)
                
                let moreResults = result.characters
                apiInfo = result.info

                characters.append(contentsOf: moreResults)
                isLoadingMoreCharacters = false
                errorManager.clearError()
            } catch {
                print(error.localizedDescription)
                errorManager.showError(error.localizedDescription)
                isLoadingMoreCharacters = false
            }
        }
    }
}
