//
//  CharacterDetailsVM.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import Foundation

class CharacterDetailsViewModel
{
    
    public var character: Character
    public var networkService: EpisodeService
    
    init(character: Character, networkService: EpisodeService) {
        self.character = character
        self.networkService = networkService
        startNetworking()
    }
    
    // MARK: - Observable Objects -
    
    public var reloadNeeded: ObservableObject<Bool> = ObservableObject(value: false)
    
    
    public var episodesStore = [Episode]() {
        didSet {
            reloadNeeded.value = !reloadNeeded.value
        }
    }
    
    
    public func getEpisode(with indexPath: IndexPath) -> Episode {
        return episodesStore[indexPath.row]
    }
    
    private func prepareDataForNetworkCall(urlCollection: [String]) -> String {
        var tmpArray: [String] = []
        for urlString in urlCollection {
            tmpArray.append(urlString.digits)
        }
        let queryString = tmpArray.joined(separator: ",")
        print(queryString)
        return queryString
    }
    
    private func startNetworking() {
        Task(priority: .background) {
            let result = await networkService.getSelectedEpisodes(IDs: prepareDataForNetworkCall(urlCollection: character.episode))
            switch result {
            case .success(let response):
                episodesStore = response.results
            case .failure(let error):
                dump(error)
            }
        }
    }
}
