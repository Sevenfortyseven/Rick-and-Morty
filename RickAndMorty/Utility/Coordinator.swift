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
    public var navigationController: UINavigationController?
    
    public func start() {
        let initialVM = HomeViewModel()
        let initialVC = HomeViewController(viewModel: initialVM)
        
        navigationController?.setViewControllers([initialVC], animated: false)
    }
    
}
