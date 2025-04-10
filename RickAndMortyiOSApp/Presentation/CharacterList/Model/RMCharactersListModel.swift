//
//  RMCharactersSelectorModel.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 9/4/25.
//

import Foundation

struct RMCharactersListModel {
    var characters: [RMCharacterEntity]
    var isFetchDataFinished: Bool = false
    
    init(characters: [RMCharacterEntity] = [], isFetchDataFinished: Bool = true) {
        self.characters = characters
        self.isFetchDataFinished = isFetchDataFinished
    }
}
