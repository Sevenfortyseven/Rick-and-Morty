//
//  Character.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation


struct Character: Codable
{
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [Episode]
    let url: String
    let created: String
}


extension Character
{
    struct NetworkResponse: Codable {
        let info: Info
        let results: [Character]
    }
}
