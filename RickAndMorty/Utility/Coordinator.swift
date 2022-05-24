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
    public var tabBarController: UITabBarController
    
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
   
    public func start() {
        // create Navigation Controllers
        let episodesNV = UINavigationController()
        let charactersNV = UINavigationController()
        let locationsNV = UINavigationController()
        
        // Create ViewModels
        let episodesVM = EpisodesViewModel(networkService: EpisodeService())
        
        // Create ViewControllers
        let episodesVC = EpisodesViewController(viewModel: episodesVM)
        episodesVC.delegate = self
        episodesVC.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(named: ImageStore.episodesIcon.rawValue), tag: 1)
        
        let charactersVC = CharactersViewController()
        charactersVC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(named: ImageStore.charactersIcon.rawValue), tag: 2)
        
        let locationsVC = LocationsViewController()
        locationsVC.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(named: ImageStore.locationsIcon.rawValue), tag: 3)
        
        // Configure tabbar tree
        episodesNV.viewControllers = [episodesVC]
        charactersNV.viewControllers = [charactersVC]
        locationsNV.viewControllers = [locationsVC]
      
    
        configureTabBar()
        tabBarController.viewControllers = [episodesNV, locationsNV, charactersNV]
        
        
    }
    
    /// Configure tabBar
    private func configureTabBar() {
        tabBarController.tabBar.barStyle = .black

    }
}

extension Coordinator: EpisodesViewControllerDelegate
{
    func didSelect() {
        print("Instantiating")
    }
    
    
    
}
