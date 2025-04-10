//
//  CharacterDetailView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI

struct RMCharacterDetailView: View {
    @StateObject var viewModel: RMCharacterDetailViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y: 0)
                        .ignoresSafeArea()
                VStack {
                    RMCharacterProfileImageView(status: $viewModel.model.status, image: $viewModel.model.image)
                    VStack {
                        HStack(spacing: 16) {
                            RMCharacterDetailTypeView(type: "GENDER", value: $viewModel.model.gender, secondValue: .constant(""))
                            RMCharacterDetailTypeView(type: "SPECIES", value: $viewModel.model.species, secondValue: .constant(""))
                        }
                        
                        RMCharacterDetailTypeView(type: "ORIGIN / LOCATION", value: $viewModel.model.origin, secondValue: $viewModel.model.location)
                            .padding(.top)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .padding(.bottom, -20)
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Featured Episodes")
                        .font(.headline)
                        .foregroundColor(Color(.darkGray))
                        .padding(.top, 20)
                        .padding(.bottom, 4)
                    
                    ForEach(Array(viewModel.model.episodes.enumerated()), id: \.offset) { index, episode in
                        RMEpisodeCellView(episode: episode)
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, -30)
            .background(Color(.lightGray).opacity(0.1))
            .frame(maxWidth: .infinity)
        }
        .padding(.bottom, 16)
        .navigationTitle(viewModel.model.name)
        .navigationBarTitleDisplayMode(.inline)
        .handleError(with: viewModel.errorManager)
    }
}

#Preview {
    let character = RMCharacterEntity(
        decodable: RMCharacterDecodable(
            id: 2,
            name: "Morty Smith",
            status: RMCharacterStatusEntity.Alive.rawValue,
            species: "Human",
            type: "",
            gender: "Male",
            origin: RMCharacterLocationDecodable(name: "Earth", url: ""),
            location: RMCharacterLocationDecodable(name: "Los angeles", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            episode: ["https://rickandmortyapi.com/api/episode/28"],
            url: "",
            created: ""
        )
    )
    
    RMCharacterDetailView(viewModel: RMCharacterDetailViewModel(episodesUseCase: DefaultRMEpisodesUseCase(repository: DefaultRMEpisodesRepository()), inputModel: character))

}
