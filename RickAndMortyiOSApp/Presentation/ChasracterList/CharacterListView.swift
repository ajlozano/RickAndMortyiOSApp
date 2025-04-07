//
//  CaharcterListView.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel: CharacterListViewModel
    @State private var navigationPath = NavigationPath()
    @State private var headerOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack {
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: HeaderOffsetKey.self,
                                        value: proxy.frame(in: .named("scroll")).minY)
                    }
                    .frame(height: 0)
                    .onPreferenceChange(HeaderOffsetKey.self) { value in
                        headerOffset = value
                    }
                    
                    LazyVGrid(columns: viewModel.columns, spacing: 16) {
                        ForEach(viewModel.characters, id: \.id) { character in
                            CharacterCellView(imageService: viewModel.imageService, character: character)
                            .onTapGesture {
                                navigationPath.append(character)
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
                    .padding(.top, viewModel.maxHeaderHeight)
                }
            }
            .coordinateSpace(name: "scroll")
            .overlay(
                headerView
                    .frame(height: calculatedHeaderHeight)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(.ultraThinMaterial)
                    .overlay(Divider(), alignment: .bottom)
                , alignment: .top
            )
            .navigationDestination(for: Character.self) { character in
                CharacterDetailView(character: character, imageService: viewModel.imageService)
            }
            .navigationBarHidden(true)
            .navigationTitle("Characters")
        }
        .handleError(with: viewModel.errorManager)
    }
    
    var calculatedHeaderHeight: CGFloat {
        let offset = -headerOffset
        return max(viewModel.minHeaderHeight, viewModel.maxHeaderHeight - offset)
    }
    
    // El header escala el texto en función del progreso de colapso
    var headerView: some View {
        let collapseRange = viewModel.maxHeaderHeight - viewModel.minHeaderHeight
        // Solo calculamos el progreso si headerOffset es negativo (se ha hecho scroll hacia arriba)
        let speedFactor: CGFloat = 0.5
        let progress = headerOffset < 0 ? min(1, max(0, (-headerOffset) / collapseRange * speedFactor)) : 0
        let scale = 1 - (1 - viewModel.minScale) * progress
        
        return Text("Rick And Morty")
            .font(.system(size: 50))
            .bold()
            .scaleEffect(scale, anchor: .center)
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

private struct HeaderOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct CharacterListView_Previews: PreviewProvider {
    class MockImageService: ImageService {
        func loadImage(from url: URL) async -> UIImage? {
            return UIImage(systemName: "person.fill")
        }
    }

    class MockFetchAllCharactersUseCase: FetchAllCharactersUseCase {
        func execute(_ request: RMRequest) async throws -> CharacterList {
            let character = Character(id: 2,
                                      name: "Morty Smith",
                                      status: .alive,
                                      species: "Human",
                                      type: "",
                                      gender: .male,
                                      origin: Origin(name: "", url: ""),
                                      location: SingleLocation(name: "", url: ""),
                                      image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                                      episode: [],
                                      url: "",
                                      created: "")
            return CharacterList(
                info: CharacterList.Info(count: 1, pages: 1, next: "", prev: ""),
                characters: [character, character, character]
            )
        }
    }

    static var previews: some View {
        let mockUseCase = MockFetchAllCharactersUseCase()
        let mockImageService = MockImageService()
        let viewModel = CharacterListViewModel(useCase: mockUseCase, imageService: mockImageService)

        CharacterListView(viewModel: viewModel)
    }
}
