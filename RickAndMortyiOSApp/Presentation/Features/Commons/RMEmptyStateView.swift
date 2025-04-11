//
//  RMEmptyStateView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 11/4/25.
//

import SwiftUI
import Lottie

struct RMEmptyStateView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("empty_state_message".localized)
                .font(.custom("Shlop-Regular", size: 40))
            LottieView(animationName: "39138-morty-cry-loader")
        }
    }
}

#Preview {
    RMEmptyStateView()
}
