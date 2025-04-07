//
//  SplashView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 7/4/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.black
            Image("cover")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .cornerRadius(20)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
