//
//  RickAndMortyEndpoint.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation

enum RickAndMortyEndpoint
{
    case allEpisodes(page: Int)
}

extension RickAndMortyEndpoint: Endpoint
{
    var scheme: String {
        switch self {
        case .allEpisodes:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .allEpisodes:
            return "rickandmortyapi.com"
        }
        
    }
    
    var path: String {
        switch self {
        case .allEpisodes:
            return "/api/episode"
        }
    }
    
    var queryParams: [URLQueryItem]? {
        switch self {
        case .allEpisodes(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .allEpisodes:
            return nil
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .allEpisodes:
            return nil
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .allEpisodes:
            return .GET
        }
    }
    
    
}
