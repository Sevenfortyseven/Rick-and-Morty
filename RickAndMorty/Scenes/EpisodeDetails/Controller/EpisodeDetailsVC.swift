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
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func addSubviews() {
        view.addSubview(charactersCollectionView)
        view.addSubview(charactersLabel)
    }
    
    
    // MARK: -- UI Configuration --
    
    private func updateUI() {
        
    }
    
    
    // MARK: -- UI Elements --
    
    private let charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .red
        return cv
    }()
    
    private let charactersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title1, compatibleWith: .init(legibilityWeight: .bold))
        label.text = "Characters"
        return label
    }()
    
}


extension EpisodeDetailsviewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    
    // MARK: -- CollectionView Delegate Methods & Configuration
    
    private func setupCollectionView() {
        charactersCollectionView.register(CharactersCollectionCell.self, forCellWithReuseIdentifier: CharactersCollectionCell.identifier)
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characterStore.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionCell.identifier, for: indexPath) as! CharactersCollectionCell
        cell.viewmo
        return cell
    }
    
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
        
        constraints.append(charactersLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GlobalConstants.leadingOffset))
        constraints.append(charactersLabel.bottomAnchor.constraint(equalTo: charactersCollectionView.topAnchor, constant: GlobalConstants.itemOffsetN))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}