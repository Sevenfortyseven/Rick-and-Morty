//
//  EpisodeDetailsVM.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import Foundation


class EpisodeDetailsViewModel
{
    let episode: Episode
    let networkService: CharacterService
    
    init(episode: Episode, networkService: CharacterService) {
        self.episode = episode
        self.networkService = networkService
        startNetworking()
    }
    
    public var characterStore = [Character]() {
        didSet {
            reloadNeeded.value = !reloadNeeded.value
        }
    }
    
    public var reloadNeeded: ObservableObject = ObservableObject(value: false)
    
    
    /// Episode.characters give us full url strings of characters,
    /// but we need only query ID-s so we filter them and
    /// transform from URLstring array into single query id string
    private func prepareDataForNetworkCall(urlCollection: [String]) -> String {
        var tmpArray: [String] = []
        for urlString in urlCollection {
            tmpArray.append(urlString.digits)
        }
        let queryString = tmpArray.joined(separator: ",")
        return queryString
    }
    
    private func startNetworking() {
        Task(priority: .background) {
            let result = await networkService.getSelectedCharacters(selectedIDs: prepareDataForNetworkCall(urlCollection: episode.characters))
            switch result {
            case .success(let response):
                characterStore = response.results
            case .failure(let error):
                print(error)
            }
        }
    }
}
