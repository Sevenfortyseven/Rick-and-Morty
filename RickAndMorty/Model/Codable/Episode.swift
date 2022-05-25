//
//  Episode.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation

struct Episode: Codable
{

    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, episode, characters
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
