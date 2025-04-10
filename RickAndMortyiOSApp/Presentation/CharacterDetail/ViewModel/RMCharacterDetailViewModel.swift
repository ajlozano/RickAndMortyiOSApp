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
    @Published var profileImage: UIImage?
    @Published var loadingStatus: RMLoadingStatus = .stop
    @Published var model: RMCharacterDetailModel = RMCharacterDetailModel()
    var inputModel: RMCharacterEntity?
    
    var episodesUseCase: RMEpisodesUseCase
    
    init(episodesUseCase: RMEpisodesUseCase, inputModel: RMCharacterEntity) {
        self.episodesUseCase = episodesUseCase
        self.inputModel = inputModel
        
        fetchData()
    }
}

// MARK: Fetch Data Methods

extension RMCharacterDetailViewModel {
    
    func fetchData() {

        let episodesIDs = inputModel?.episode?.compactMap({ $0.split(separator: "/").last.map(String.init) ?? "0" })
        
        loadingStatus = .start
        let useCaseParameters = RMEpisodesUseCaseParameters(episodesIDs: episodesIDs)
        Task {
            do {
                let result = try await episodesUseCase.execute(params: useCaseParameters)
                loadingStatus = .stop
                createModel(for: result)
            } catch {
                loadingStatus = .stop
                createErrorModel(error)
            }
        }
    }
    
    func loadImage() {
        guard let imagePath = model.imagePath else { return }
        
        Task {
            let imageData = await RMImageCacheManager.shared.loadImage(forKey: imagePath)
            guard let imageData = imageData else { return }
            
            model.image = UIImage(data: imageData)
        }
    }
}

// MARK: Create Models

extension RMCharacterDetailViewModel {
   
    /// This method inflates a model of the view
    /// - Parameters:
    ///   - entity: Entity model result of the Episodes request.
    func createModel(for entity: RMEpisodesListEntity) {
        guard let imagePath = inputModel?.image,
              let status = inputModel?.status,
              let gender = inputModel?.gender?.rawValue,
              let species = inputModel?.species,
              let origin = inputModel?.origin?.name,
              let location = inputModel?.location?.name,
              let episodes = entity.results else {
            
            errorManager.showError("Could not get detail model in RMCharacterDetailViewModel")
            return
        }

        model.imagePath = imagePath
        model.status = status
        model.gender = gender
        model.species = species
        model.origin = origin
        model.location = location
        model.episodes = episodes
        
        loadImage()
    }

    /// This method inflates an error model for data binding with the viewController
    /// - Parameter error: Value of the error occurred
    func createErrorModel(_ error: Error) {
        if let error = error as? RMError {
            errorManager.showError(from: error)
        } else {
            errorManager.showError(error.localizedDescription)
        }
    }
}
