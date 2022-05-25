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
    func searchEpisodes(searchText: String) async -> Result<Episode.NetworkResponse, RequestError>
    func getSelectedEpisodes(IDs: String) async -> Result<Episode.NetworkResponse, RequestError>
}


struct EpisodeService: NetworkEngine, EpisodeServicable
{
    func getSelectedEpisodes(IDs: String) async -> Result<Episode.NetworkResponse, RequestError> {
        return await sendRequest(endpoint: RickAndMortyEndpoint.getSelectedEpisodes(IDs: IDs), responseModel: Episode.NetworkResponse.self)
    }
    
    func getAllEpisodes(page: Int) async -> Result<Episode.NetworkResponse, RequestError> {
        return await sendRequest(endpoint: RickAndMortyEndpoint.allEpisodes(page: page), responseModel: Episode.NetworkResponse.self)
    }
    
    func searchEpisodes(searchText: String) async -> Result<Episode.NetworkResponse, RequestError> {
        return await sendRequest(endpoint: RickAndMortyEndpoint.searchEpisodes(searchText: searchText), responseModel: Episode.NetworkResponse.self)
    }
    
}
