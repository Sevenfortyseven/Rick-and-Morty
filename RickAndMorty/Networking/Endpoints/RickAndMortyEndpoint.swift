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
    case searchEpisodes(searchText: String)
}

extension RickAndMortyEndpoint: Endpoint
{
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        default:
            return "rickandmortyapi.com"
        }
        
    }
    
    var path: String {
        switch self {
        default:
            return "/api/episode"
        }
    }
    
    var queryParams: [URLQueryItem]? {
        switch self {
        case .allEpisodes(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        case .searchEpisodes(let searchText):
            return [URLQueryItem(name: "name", value: searchText)]
        }
    }
    
    var body: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var header: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var method: RequestMethod {
        switch self {
        default:
            return .GET
        }
    }
    
    
}
