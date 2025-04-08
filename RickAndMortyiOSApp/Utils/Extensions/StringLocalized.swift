//
//  StringLocalized.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 9/4/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
