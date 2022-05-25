//
//  EpisodeDetailsVC.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import Foundation
import UIKit


class EpisodeDetailsviewController: UIViewController
{
    
    public var viewModel: EpisodeDetailsViewModel
    
    
    // MARK: -- Initialization
    
    init(viewModel: EpisodeDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        initializeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func addSubviews() {
        view.addSubview(charactersCollectionView)
    }
    
    
    // MARK: -- UI Configuration --
    
    
    
    
    
    
    // MARK: -- UI Elements --
    
    private let charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .red
        return cv
    }()
    
}



extension EpisodeDetailsviewController
{
    // MARK: -- Constraints --
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        
        constraints.append(charactersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(charactersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(charactersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(charactersCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: GlobalConstants.scrollViewHMulti))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
