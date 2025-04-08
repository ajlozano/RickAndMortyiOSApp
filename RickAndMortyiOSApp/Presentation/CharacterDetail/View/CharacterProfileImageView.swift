//
//  CharacterProfileImageView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import SwiftUI

struct CharacterProfileImageView: View {
    let imageService: ImageService
    let status: RMCharacterStatusEntity
    let imageUrl: String
    @State private var image: UIImage?
    
    private var statusColor: Color {
        switch status {
        case .Alive:   return .green
        case .Dead:    return .red
        case .Unknown: return .gray
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Rectangle()
                    .frame(height: 105)
                    .foregroundStyle(statusColor)
                Spacer()
            }
            Circle()
                .strokeBorder(statusColor, lineWidth: 10)
                .frame(width: 150, height: 150)
                .overlay(
                    ZStack {
                        if let img = image {
                            Image(uiImage: img)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            statusColor.opacity(0.2)
                            ProgressView()
                        }
                    }
                        .frame(height: 143)
                    .clipShape(Circle())
                )
            
            // Pequeño label para el estatus sobre el borde inferior
            Text(status.rawValue)
                .font(.system(size: 20)).bold()
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(statusColor)
                .clipShape(Capsule())
                .offset(y: 12)
        }
        .frame(height: 180)
        .padding(.top, 16)
        .task {
            if let url = URL(string: imageUrl) {
                image = await imageService.loadImage(from: url)
            }
        }
    }
}

#Preview {
    CharacterProfileImageView(imageService: ImageServiceImpl(), status: .Dead, imageUrl: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
}
