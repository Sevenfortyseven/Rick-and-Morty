//
//  Episode.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation

struct Episode: Codable
{
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [URL]
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, created
        case airDate = "air_date"
    }
    
}

extension Episode
{
    struct NetworkResponse: Codable {
        var info: Info
        var results: [Episode]
    }
    
 
}
