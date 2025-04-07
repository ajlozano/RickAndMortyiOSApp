//
//  FetchAllCharactersResponseModel.swift
//  RickAndMortyiOSApp
//
//  Created by Toni Lozano Fernández on 6/4/25.
//

import Foundation

struct GetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [Character]
    
    func mapResponse() -> CharacterList {
        let characters = self.results.map {
            Character(
                id: $0.id,
                name: $0.name,
                status: $0.status,
                species: $0.species,
                type: $0.type,
                gender: $0.gender,
                origin: $0.origin,
                location: $0.location,
                image: $0.image,
                episode: $0.episode,
                url: $0.url,
                created: $0.created)
        }
        
        let info = CharacterList.Info(
            count: self.info.count,
            pages: self.info.pages,
            next: self.info.next,
            prev: self.info.prev)
        
        return CharacterList(info: info, characters: characters)
    }
}
