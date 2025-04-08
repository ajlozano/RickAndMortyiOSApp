//
//  CharacterDetailView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let imageService: ImageService
    let character: RMCharacterEntity
    @State private var image: UIImage?
    
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y: 0)
                        .ignoresSafeArea()
                VStack {
                    CharacterProfileImageView(imageService: imageService, status: character.status ?? RMCharacterStatusEntity.Unknown, imageUrl: character.image ?? "")
                    VStack {
                        HStack(spacing: 16) {
                            CharacterDetailTypeView(type: "GENDER", value: character.gender?.rawValue ?? RMCharacterGenderEntity.Unknown.rawValue)
                            CharacterDetailTypeView(type: "SPECIES", value: character.species ?? "")
                        }
                        
                        CharacterDetailTypeView(type: "ORIGIN / LOCATION", value: character.origin.name, secondValue: character.location.name)
                            .padding(.top)
                    }
                    .padding(.horizontal, -30)
                }
            }
            .padding(.bottom, -16)
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Featured Episodes")
                        .font(.headline)
                        .padding(.bottom, 4)
                    
                    ForEach(Array(character.episodes.enumerated()), id: \.offset) { index, episode in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Episodio prueba")
                                .fontWeight(.semibold)
                            Text("Fecha episodio")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .background(.white)
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.bottom, 16)
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if let url = URL(string: character.image) {
                image = await imageService.loadImage(from: url)
            }
        }
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
            origin: RMCharacterLocationDecodable(name: "", url: ""),
            location: RMCharacterLocationDecodable(name: "", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            episode: [],
            url: "",
            created: ""
        )
    )
    
    CharacterDetailView(imageService: ImageServiceImpl(), character: character)

}
