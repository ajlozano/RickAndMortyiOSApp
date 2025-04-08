//
//  RMCharacterGenderEntity.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 8/4/25.
//

import Foundation

enum RMCharacterGenderEntity: String, Equatable {
    
    /// Representation for all the Gender available cases ('Female', 'Male', 'Genderless' or 'unknown')
    case Female, Male, Genderless, Unknown
    
    init(stringValue: String) {
        switch stringValue {
        case String(describing: RMCharacterGenderEntity.Female):
            self = .Female
        case String(describing: RMCharacterGenderEntity.Male):
            self = .Male
        case String(describing: RMCharacterGenderEntity.Genderless):
            self = .Genderless
        default:
            self = .Unknown
        }
    }
}
