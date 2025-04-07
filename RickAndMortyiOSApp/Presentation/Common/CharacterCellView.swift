//
//  CharacterCellView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI

struct CharacterCellView: View {
    let imageService: ImageService
    let character: Character
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
            
            Text(character.name)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.label))
                .scaledToFit()
            Text(character.status.rawValue)
                .font(.title2).opacity(0.7)
                .fontWeight(.semibold)
                .foregroundColor(Color(.label))
                .scaledToFit()
        }
        .padding(.bottom, 8)
        .padding(.horizontal, 4)
        .task {
            if let url = URL(string: character.image) {
                image = await imageService.loadImage(from: url)
            }
        }
    }
}

#Preview {
    let character = Character(
        id: 2,
        name: "Morty Smith",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: Origin(name: "", url: ""),
        location: SingleLocation(name: "", url: ""),
        image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        //image: "",
        episode: [],
        url: "",
        created: ""
    )
    
    CharacterCellView(imageService: ImageServiceImpl(), character: character)

}
