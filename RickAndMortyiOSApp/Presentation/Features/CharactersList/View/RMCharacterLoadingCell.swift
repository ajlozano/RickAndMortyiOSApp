//
//  RMCharacterLoadingCell.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 11/4/25.
//

import SwiftUI
import Lottie

struct RMCharacterLoadingCell: View {
    var body: some View {
        VStack(alignment: .center) {
            LottieView(animationName: "98770-assistagro-loading-bars")
        }
    }
}

#Preview {
    RMCharacterLoadingCell()
}
