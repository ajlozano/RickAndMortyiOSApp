//
//  CaharcterListView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()

    var body: some View {
        ZStack {
            if viewModel.isInitialLoading {
                SplashView()
            } else {
                NavigationStack {
                    List {
                        ForEach(viewModel.characters, id: \.id) { character in
                            HStack {
                                Text(character.name)
                                    .font(.headline)
                                Spacer()
                                Text(character.status.text)
                                    .font(.subheadline)
                                    .foregroundStyle(character.status == .alive ? .green : .gray)
                            }
                            .onAppear {
                                viewModel.loadMoreCharactersIfNeeded(currentCharacter: character)
                            }
                        }
                        
                        if viewModel.isLoadingMoreCharacters {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    }
                    .listStyle(.plain)
                    .edgesIgnoringSafeArea([])
                }
                .navigationTitle("Personajes")
            }
            
            
        }
        .task {
            viewModel.fetchCharacters()
        }
        .handleError(with: viewModel.errorManager)
        .animation(.easeInOut, value: viewModel.isInitialLoading)
    }
}

#Preview {
    CharacterListView()
}
