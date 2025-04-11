//
//  CaharcterListView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI

struct RMCharactersListView: View {
    @Environment(\.appDependencies) var appDependencies: AppDependencies
    @State private var navigationPath = NavigationPath()
    @StateObject var viewModel: RMCharactersListViewModel
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                if viewModel.showEmptyStateError {
                    RMEmptyStateView()
                        .padding(.top, 100)
                } else {
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
                }
                
            }
            .navigationBarHidden(false)
            .navigationTitle("characters_Navigation_Title".localized)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
