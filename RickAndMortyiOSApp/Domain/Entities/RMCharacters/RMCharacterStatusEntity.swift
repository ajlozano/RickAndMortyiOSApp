//
//  RMCharacterStatusEntity.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

enum RMCharacterStatusEntity: String, Equatable {
    
    /// Representation for all the Status available cases ('Alive', 'Dead' or 'unknown')
    case Alive, Dead, Unknown
    
    init(stringValue: String) {
        switch stringValue {
        case String(describing: RMCharacterStatusEntity.Alive):
            self = .Alive
        case String(describing: RMCharacterStatusEntity.Dead):
            self = .Dead
        default:
            self = .Unknown
        }
    }
}
