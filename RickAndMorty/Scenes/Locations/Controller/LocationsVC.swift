//
//  LocationsVC.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation
import UIKit

final class LocationsViewController: UIViewController
{
    // MARK: -- Initialization --
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        initializeConstraints()
    }
    
    
    private func addSubviews() {
        view.addSubview(background)
    }
    
    // MARK: -- UI Configuration --
    
    
    
    // MARK: -- UI Elements --
    
    private var background: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.contentMode = .scaleAspectFill
        background.image = UIImage(named: ImageStore.mainBackground.rawValue)
        return background
    }()
    
}


extension LocationsViewController
{
    // MARK: -- Constraints --
    
    private func initializeConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(background.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(background.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(background.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(background.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
