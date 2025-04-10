//
//  CharacterCellView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI

struct RMCharacterCellView: View {
    let character: RMCharacterEntity
    @State private var image: UIImage?
    
    var body: some View {
        VStack {
            VStack {
                if let img = image {
                    Image(uiImage: img)
                        .resizable()
                } else {
                    Color.green.opacity(0.2)
                    ProgressView()
                }
            }
            .cornerRadius(8)
            .scaledToFit()
            
            Text(character.name ?? "")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.label))
                .scaledToFit()
        }
        .task {
            if let imageString = character.image, let data = await RMImageCacheManager.shared.loadImage(forKey: imageString) {
                image = UIImage(data: data)
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
    
    RMCharacterCellView(character: character)

}
