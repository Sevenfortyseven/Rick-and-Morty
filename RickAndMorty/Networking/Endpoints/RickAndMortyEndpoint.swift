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
    case getSelectedCharacters(IDs: String)
    case getSelectedEpisodes(IDs: String)
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
        case .getSelectedCharacters:
            return "/api/character"
        case .getSelectedEpisodes:
            return "/api/episode"
        case .allEpisodes:
            return "/api/episode"
        case .searchEpisodes:
            return "/api/episode"
        }
    }
    
    var queryParams: [URLQueryItem]? {
        switch self {
        case .allEpisodes(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        case .searchEpisodes(let searchText):
            return [URLQueryItem(name: "name", value: searchText)]
        case .getSelectedCharacters(let IDs):
            return [URLQueryItem(name: "ids", value: IDs)]
        case .getSelectedEpisodes(let IDs):
            return [URLQueryItem(name: "ids", value: IDs)]
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
