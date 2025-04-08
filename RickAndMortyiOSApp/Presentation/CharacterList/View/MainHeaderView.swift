//
//  MainHeaderView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 7/4/25.
//

import SwiftUI

var headerView: some View {
    Text("Rick And Morty")
        .font(.largeTitle.bold())
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
}
