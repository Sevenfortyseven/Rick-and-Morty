//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation
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
        
        navigationController.pushViewController(targetVC, animated: true)
        
    }
    
    
    
}
