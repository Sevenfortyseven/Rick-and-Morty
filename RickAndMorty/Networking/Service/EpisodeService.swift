//
//  EpisodeService.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation

protocol EpisodeServicable
{
    func getAllEpisodes() async -> Result<Episode.NetworkResponse, RequestError>
}


struct EpisodeService: NetworkEngine, EpisodeServicable
{
    func getAllEpisodes() async -> Result<Episode.NetworkResponse, RequestError> {
        return await sendRequest(endpoint: RickAndMortyEndpoint.allEpisodes, responseModel: Episode.NetworkResponse.self)
    }
    
    
}
