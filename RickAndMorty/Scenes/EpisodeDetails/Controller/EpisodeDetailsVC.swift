//
//  EpisodeDetailsVC.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import UIKit

protocol EpisodeDetailsViewControllerDelegate: AnyObject {
    func didSelect(character: Character)
}

class EpisodeDetailsviewController: BaseViewController {
    weak var delegate: EpisodeDetailsViewControllerDelegate?
    public var viewModel: EpisodeDetailsViewModel
    private lazy var episodeInfoModule = EpisodeInfoModule()
    private var landscapeConstraints: [NSLayoutConstraint] = []
    private var portraitConstraints: [NSLayoutConstraint] = []
    
    // MARK: -- Initialization
    
    init(viewModel: EpisodeDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        initializeConstraints()
    }

    
    private func addSubviews() {
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
        btn.tintColor = .accentColor
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
        return CGSize(width: 175, height: 170)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(character: viewModel.getSelectedCharacter(with: indexPath))
    }
}

extension EpisodeDetailsviewController {
    // MARK: -- Constraints --
    
    private func initializeConstraints() {
        // Clear existing constraints
        NSLayoutConstraint.deactivate(landscapeConstraints + portraitConstraints)
        landscapeConstraints.removeAll()
        portraitConstraints.removeAll()

        portraitConstraints.append(charactersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GlobalConstants.collectionLeading))
        portraitConstraints.append(charactersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: GlobalConstants.CollectionTrailing))
        portraitConstraints.append(charactersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        portraitConstraints.append(charactersCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: GlobalConstants.scrollViewHMultiMedium))

        portraitConstraints.append(charactersLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GlobalConstants.leadingOffset))
        portraitConstraints.append(charactersLabel.bottomAnchor.constraint(equalTo: charactersCollectionView.topAnchor, constant: GlobalConstants.itemOffsetN))

        portraitConstraints.append(episodeInfoModule.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        portraitConstraints.append(episodeInfoModule.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        portraitConstraints.append(episodeInfoModule.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8))

        portraitConstraints.append(watchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: GlobalConstants.trailingOffset))
        portraitConstraints.append(watchButton.centerYAnchor.constraint(equalTo: charactersLabel.centerYAnchor))

        // Landscape constraints
        landscapeConstraints.append(charactersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        landscapeConstraints.append(charactersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        landscapeConstraints.append(charactersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120))
        landscapeConstraints.append(charactersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))

        landscapeConstraints.append(charactersLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GlobalConstants.leadingOffset))
        landscapeConstraints.append(charactersLabel.bottomAnchor.constraint(equalTo: charactersCollectionView.topAnchor, constant: GlobalConstants.itemOffsetN))

        landscapeConstraints.append(episodeInfoModule.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        landscapeConstraints.append(episodeInfoModule.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  GlobalConstants.ScrollView.itemPadding))


        landscapeConstraints.append(watchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: GlobalConstants.trailingOffset))
        landscapeConstraints.append(watchButton.centerYAnchor.constraint(equalTo: episodeInfoModule.centerYAnchor))

        let constraints = UIDevice.current.isLandscapeOrFlat ? landscapeConstraints : portraitConstraints
        NSLayoutConstraint.activate(constraints)
    }
    
}
