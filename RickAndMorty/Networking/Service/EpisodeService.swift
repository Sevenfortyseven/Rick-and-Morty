//
//  EpisodeService.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation

protocol EpisodeServicable
{
    func getAllEpisodes(page: Int) async -> Result<Episode.NetworkResponse, RequestError>
}


struct EpisodeService: NetworkEngine, EpisodeServicable
{
    func getAllEpisodes(page: Int) async -> Result<Episode.NetworkResponse, RequestError> {
        return await sendRequest(endpoint: RickAndMortyEndpoint.allEpisodes(page: page), responseModel: Episode.NetworkResponse.self)
    }
    
    
}
