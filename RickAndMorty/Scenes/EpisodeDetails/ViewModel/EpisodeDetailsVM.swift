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
        if NetworkMonitor.shared.isConnected {
            print("ON")
            internetConnection.value = true
            startNetworking()
        } else {
            internetConnection.value = false
        }
        
        
        defer {
            episodeName.value = episode.name
            episodeAirDate.value = episode.airDate
            episodeinfo.value = episode.episode
        }
    }
    
    public var characterStore = [Character]() {
        didSet {
            reloadNeeded.value = !reloadNeeded.value
        }
    }
    
    public var internetConnection: ObservableObject<Bool?> = ObservableObject(value: nil)
    public var reloadNeeded: ObservableObject<Bool> = ObservableObject(value: false)
    public var episodeName: ObservableObject<String?> = ObservableObject(value: nil)
    public var episodeAirDate: ObservableObject<String?> = ObservableObject(value: nil)
    public var episodeinfo: ObservableObject<String?> = ObservableObject(value: nil)
    
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
    
    public func getSelectedCharacter(with indexPath: IndexPath) -> Character {
        return characterStore[indexPath.row]
    }
    
    /// Directs user on Imovies.ge to watch chosen episode
    public func watchEpisode() -> URL {
        return imoviesEndpoint.transferToSite.createEndpoint(with: episode.episode)!
      
    }
}
