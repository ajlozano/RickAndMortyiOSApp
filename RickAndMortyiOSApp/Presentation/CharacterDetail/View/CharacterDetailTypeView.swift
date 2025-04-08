//
//  CharacterDetailTypeView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import SwiftUI

struct CharacterDetailTypeView: View {
    let type: String
    let value: String
    let secondValue: String
    
    init(type: String, value: String, secondValue: String = "") {
        self.type = type
        self.value = value
        self.secondValue = secondValue
    }
    
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

#Preview {
    CharacterDetailTypeView(type: "ORIGIN / LOCATION", value: "Earth", secondValue: "Citadel of Ricks")
}
