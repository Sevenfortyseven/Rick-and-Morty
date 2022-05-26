//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import UIKit

final class Coordinator
{
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        // Initial VC setup
        let episodesVM = EpisodesViewModel(networkService: EpisodeService())
        let episodesVC = EpisodesViewController(viewModel: episodesVM)
        episodesVC.delegate = self
        navigationController.setViewControllers([episodesVC], animated: false)
    }
    
}

extension Coordinator: EpisodesViewControllerDelegate
{
    
    func didSelect(episode: Episode) {
        let targetVM = EpisodeDetailsViewModel(episode: episode, networkService: CharacterService())
        let targetVC = EpisodeDetailsviewController(viewModel: targetVM)
        targetVC.delegate = self
        DispatchQueue.main.async {
            self.navigationController.pushViewController(targetVC, animated: true)
        }
        
    }
    
}


extension Coordinator: EpisodeDetailsViewControllerDelegate
{
    func didSelect(character: Character) {
        let targetVM = CharacterDetailsViewModel(character: character, networkService: EpisodeService())
        let targetVC = CharacterDetailsViewController(viewModel: targetVM)
        targetVC.delegate = self
        DispatchQueue.main.async {
            self.navigationController.pushViewController(targetVC, animated: true)
        }
    }
    
    
}

extension Coordinator: CharacterDetailsViewControllerDelegate
{
    func episodeSelected(episode: Episode) {
        let targetVM = EpisodeDetailsViewModel(episode: episode, networkService: CharacterService())
        let targetVC = EpisodeDetailsviewController(viewModel: targetVM)
        targetVC.delegate = self
        let currentRootVC = navigationController.viewControllers[0]
        DispatchQueue.main.async {
            self.navigationController.setViewControllers([currentRootVC, targetVC], animated: true)
        }
        
    }
    
 
        
}
