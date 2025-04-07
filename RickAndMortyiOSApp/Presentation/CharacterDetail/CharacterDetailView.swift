//
//  CharacterDetailView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    let imageService: ImageService
    @State private var image: UIImage?
    
    var body: some View {
        VStack {
            if let img = image {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Color.green.opacity(0.2)
                ProgressView()
            }
            
            Text(character.name)
                .font(.largeTitle)
                .bold()
            
            Text("Status: \(character.status.rawValue)")
                .padding(.top, 8)
            
            // Más detalles del personaje...
            
            Spacer()
        }
        .padding()
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
        .tint(Color(.label))
        .task {
            if let url = URL(string: character.image) {
                image = await imageService.loadImage(from: url)
            }
        }
    }
}
