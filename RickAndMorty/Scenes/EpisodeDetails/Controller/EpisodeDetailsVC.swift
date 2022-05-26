//
//  EpisodeDetailsVC.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import UIKit

protocol EpisodeDetailsViewControllerDelegate: AnyObject
{
    func didSelect(character: Character)
}

class EpisodeDetailsviewController: UIViewController
{
    weak var delegate: EpisodeDetailsViewControllerDelegate?
    
    public var viewModel: EpisodeDetailsViewModel
    
    private lazy var episodeInfoModule = EpisodeInfoModule()
    
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
        bindToVM()
        addTargets()
    }
    
    
    private func addSubviews() {
        view.addSubview(background)
        view.addSubview(charactersCollectionView)
        view.addSubview(charactersLabel)
        view.addSubview(episodeInfoModule)
        view.addSubview(watchButton)
    }
    
    private func bindToVM() {
        viewModel.reloadNeeded.bind { [unowned self] _ in
            DispatchQueue.main.async {
                self.charactersCollectionView.reloadData()
            }
        }
        viewModel.internetConnection.bind { [unowned self] connection in
            if connection == false {
                AlertManager.initializeAlert(show: .networkError, on: self)
            }
        }
        viewModel.episodeinfo.bind { [unowned self] info in
            episodeInfoModule.episode.text = info
        }
        viewModel.episodeName.bind { [unowned self] name in
            episodeInfoModule.episodeName.text = name
        }
        viewModel.episodeAirDate.bind { [unowned self] airDate in
            episodeInfoModule.airDate.text = airDate
        }
    }
    
    // MARK: -- UI Elements --
    
    private var background: UIImageView = {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.contentMode = .scaleToFill
        background.image = UIImage(named: ImageStore.mainBackground.rawValue)
        return background
    }()
    
    private let charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
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
    
    private var watchButton: UIButton = {
        let config = UIButton.Configuration.filled()
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Watch", for: .normal)
        btn.tintColor = .purple
        return btn
    }()
    
    @objc
    private func watchButtonPressed() {
        if let url = viewModel.watchEpisode() {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    
    // MARK: -- Targets and Actions --
    
    private func addTargets() {
        watchButton.addTarget(self, action: #selector(watchButtonPressed), for: .touchUpInside)
    }
    
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
        cell.data = viewModel.getSelectedCharacter(with: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * GlobalConstants.collectionCellWMulti,
                      height: collectionView.bounds.height * GlobalConstants.collectionCellHMulti)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(character: viewModel.getSelectedCharacter(with: indexPath))
    }
}

extension EpisodeDetailsviewController
{
    // MARK: -- Constraints --
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(background.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(background.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(background.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(background.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        constraints.append(charactersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: GlobalConstants.collectionLeading))
        constraints.append(charactersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: GlobalConstants.CollectionTrailing))
        constraints.append(charactersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(charactersCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: GlobalConstants.scrollViewHMulti))
        
        constraints.append(charactersLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GlobalConstants.leadingOffset))
        constraints.append(charactersLabel.bottomAnchor.constraint(equalTo: charactersCollectionView.topAnchor, constant: GlobalConstants.itemOffsetN))
        
        constraints.append(episodeInfoModule.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(episodeInfoModule.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(episodeInfoModule.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8))
        
        constraints.append(watchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: GlobalConstants.trailingOffset))
        constraints.append(watchButton.centerYAnchor.constraint(equalTo: charactersLabel.centerYAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
