//
//  CharacterDetailViewModel.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI

@MainActor
final class RMCharacterDetailViewModel: ObservableObject {
    @Published var errorManager: RMErrorManager = RMErrorManager()

    
    init(charactersListUseCase: RMCharactersUseCase, imageService: ImageService) {
        self.charactersUseCase = charactersListUseCase
        self.imageService = imageService
        
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
}

// MARK: Create Models

extension RMCharacterDetailViewModel {
   
    /// This method inflates a model of the view for data binding with the viewController
    /// - Parameters:
    ///   - entity: Entity model result of the Character Detail request.
    ///   - params: Parameters model for the  Character Detail request.
    func createModel(withEntity entity: RMCharacterDetailEntity, forParameters params: RMCharacterDetailUseCaseParameters) {
        guard let imagePath = inputModel?.image,
              let status = inputModel?.status,
              let gender = inputModel?.gender?.rawValue,
              let species = inputModel?.species,
              let origin = entity.locations?.filter({ $0.id == Int(params.originID) ?? 0 }).first,
              let location = entity.locations?.filter({ $0.id == Int(params.locationID) ?? 0 }).first,
              let episodes = entity.episodes else {
            
            self.error.value = RMError.unknownError(message: "Could not get detail model in RMCharacterDetailViewModel")
            return
        }
        
        self.model.value = RMCharacterDetailModel(imagePath: imagePath,
                                                  status: status,
                                                  gender: gender,
                                                  species: species,
                                                  origin: origin,
                                                  location: location,
                                                  episodes: episodes)
    }

    /// This method inflates an error model for data binding with the viewController
    /// - Parameter error: Value of the error occurred
    func createErrorModel(_ error: RMError) {
        self.error.value = error
    }
}
