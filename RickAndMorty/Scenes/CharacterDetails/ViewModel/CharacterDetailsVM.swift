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
        /// Check Internet connection before making a call
        if NetworkMonitor.shared.isConnected {
            internetConnection.value = true
            startNetworking()
        } else {
            internetConnection.value = false
        }
        
        
        defer {
            characterImage.value = character.image
            characterName.value = character.name
            characterSpeciesInfo.value = character.species
            characterStatus.value = character.status
            characterGender.value = character.gender
            characterOrigin.value = character.origin?.name
            characterDimension.value = character.origin?.dimension ?? "unknown"
        }
    }
    
    // MARK: - Observable Objects -
    public var internetConnection: ObservableObject<Bool?> = ObservableObject(value: nil)
    public var reloadNeeded: ObservableObject<Bool> = ObservableObject(value: false)
    public var characterName: ObservableObject<String?> = ObservableObject(value: nil)
    public var characterStatus: ObservableObject<String?> = ObservableObject(value: nil)
    public var characterSpeciesInfo: ObservableObject<String?> = ObservableObject(value: nil)
    public var characterGender: ObservableObject<String?> = ObservableObject(value: nil)
    public var characterImage: ObservableObject<String?> = ObservableObject(value: nil)
    public var characterOrigin: ObservableObject<String?> = ObservableObject(value: nil)
    public var characterDimension: ObservableObject<String?> = ObservableObject(value: nil)
    
    
    /// DataSource for TableView
    public var episodesStore: [Episode] = [] {
        didSet {
            reloadNeeded.value = !reloadNeeded.value
        }
    }
    
    /// Get a single episode object from episode store
    public func getEpisode(with indexPath: IndexPath) -> Episode {
        return episodesStore[indexPath.row]
    }
    
    /// obtain query parameters from url for further network call use
    private func prepareDataForNetworkCall(urlCollection: [String]) -> String {
        var tmpArray: [String] = []
        for urlString in urlCollection {
            tmpArray.append(urlString.digits)
        }
        let queryString = tmpArray.joined(separator: ",")
        return queryString
    }
    
    /// Initial Network Request
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
