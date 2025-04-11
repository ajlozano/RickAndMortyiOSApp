//
//  CharacterDetailTypeView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import SwiftUI

struct RMCharacterDetailTypeView: View {
    let type: String
    @Binding var value: String
    @Binding var secondValue: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(type)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color(.label))
            Rectangle()
                .frame(height: 2)
                .backgroundStyle(.black)
            Text(value)
                .font(.system(size: 16))
                .fontWeight(.light)
                .foregroundColor(Color(.label))
            if !secondValue.isEmpty {
                Text(secondValue)
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .foregroundColor(Color(.label))
            }
        }
    }
}

struct CharacterDetailTypeViewContainer: View {
    let type: String
    @State var value: String
    @State var secondValue: String
    
    var body: some View {
        RMCharacterDetailTypeView(type: type, value: $value, secondValue: $secondValue)
    }
}

#Preview {
    CharacterDetailTypeViewContainer(type: "ORIGIN / LOCATION", value: "Earth", secondValue: "Citadel of Ricks")
}
