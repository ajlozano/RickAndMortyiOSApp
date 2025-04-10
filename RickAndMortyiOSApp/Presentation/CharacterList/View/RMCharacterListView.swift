//
//  CaharcterListView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI

struct RMCharacterListView: View {
    @Environment(\.appDependencies) var appDependencies: AppDependencies
    @State private var navigationPath = NavigationPath()
    @StateObject var viewModel: RMCharacterListViewModel
   
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(Array(viewModel.model.characters.enumerated()), id: \.offset) { index, character in
                        RMCharacterCellView(character: character)
                        .onTapGesture {
                            navigationPath.append(character)
                        }
                        .onAppear {
                            viewModel.fetchMoreDataIfNeeded(currentCharacter: character)
                        }
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal)
            }
            .navigationDestination(for: RMCharacterEntity.self) { character in
                RMCharacterDetailView(
                    viewModel: RMCharacterDetailViewModel(
                        episodesUseCase: appDependencies.episodesUseCase,
                        inputModel: character
                    )
                )
            }
            .navigationBarHidden(false)
            .navigationTitle("Characters")
        }
    }
}

private struct HeaderOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
