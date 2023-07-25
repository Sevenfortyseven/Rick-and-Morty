//
//  CharactersVC.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import UIKit

protocol CharacterDetailsViewControllerDelegate: AnyObject {
    func episodeSelected(episode: Episode)
}


final class CharacterDetailsViewController: BaseViewController {
    weak var delegate: CharacterDetailsViewControllerDelegate?
    public var viewModel: CharacterDetailsViewModel
    private lazy var characterInfoModule = CharacterInfoModule()
    private var landscapeConstraints: [NSLayoutConstraint] = []
    private var portraitConstraints: [NSLayoutConstraint] = []
    
    // MARK: -- Initialization --
    
    init(viewModel: CharacterDetailsViewModel) {
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
        setupTableView()
        bindToVM()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
          super.viewWillTransition(to: size, with: coordinator)
          initializeConstraints()
      }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func addSubviews() {
        view.addSubview(episodesTableView)
        view.addSubview(episodesLabel)
        view.addSubview(characterInfoModule)
    }
    
    private func bindToVM() {
        viewModel.reloadNeeded.bind { [unowned self] _ in
            DispatchQueue.main.async {
                self.episodesTableView.reloadData()
            }
        }
        viewModel.internetConnection.bind { [unowned self] connection in
            if connection == false {
                AlertManager.initializeAlert(show: .networkError, on: self)
            }
        }
        viewModel.characterName.bind { [unowned self] name in
            characterInfoModule.characterName.text = name
            
        }
        viewModel.characterGender.bind { [unowned self] gender in
            characterInfoModule.characterGender.text = gender
        }
        viewModel.characterSpeciesInfo.bind { [unowned self] species in
            characterInfoModule.characterSpecies.text = species
        }
        viewModel.characterStatus.bind { [unowned self] status in
            characterInfoModule.characterStatus.text = status
        }
        viewModel.characterImage.bind { [unowned self] imageUrl in
            guard imageUrl != nil else { return }
            characterInfoModule.characterImageView.getImage(with: imageUrl!)
        }
        viewModel.characterOrigin.bind { [unowned self] origin in
            characterInfoModule.characterOrigin.text = origin
        }
        viewModel.characterDimension.bind { [unowned self] dimension in
            characterInfoModule.characterDimension.text = dimension
        }
    }
    
    
    // MARK: -- UI Elements --

    private var episodesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .black
        return tableView
    }()
    
    private var episodesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title1, compatibleWith: .init(legibilityWeight: .bold))
        label.text = "Episodes"
        return label
    }()
}


extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: -- TableView Configuration & Delegate Methods
    
    private func setupTableView() {
        episodesTableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.identifier)
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.episodesStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier, for: indexPath) as! EpisodeCell
        cell.data = viewModel.getEpisode(with: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.episodeSelected(episode: viewModel.getEpisode(with: indexPath))
    }
}


extension CharacterDetailsViewController
{
    // MARK: -- Constraints --
    
    private func initializeConstraints() {
        NSLayoutConstraint.deactivate(landscapeConstraints + portraitConstraints)
        landscapeConstraints.removeAll()
        portraitConstraints.removeAll()

        portraitConstraints.append(episodesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        portraitConstraints.append(episodesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        portraitConstraints.append(episodesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        portraitConstraints.append(episodesTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: GlobalConstants.scrollViewHMultiSmall))
        
        portraitConstraints.append(episodesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GlobalConstants.leadingOffset))
        portraitConstraints.append(episodesLabel.bottomAnchor.constraint(equalTo: episodesTableView.topAnchor, constant: GlobalConstants.itemOffsetN))
        
        portraitConstraints.append(characterInfoModule.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        portraitConstraints.append(characterInfoModule.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        portraitConstraints.append(characterInfoModule.bottomAnchor.constraint(equalTo: episodesLabel.topAnchor, constant: GlobalConstants.itemOffsetN))
        portraitConstraints.append(characterInfoModule.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3))

        landscapeConstraints.append(episodesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        landscapeConstraints.append(episodesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        landscapeConstraints.append(episodesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        landscapeConstraints.append(episodesTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4))

        landscapeConstraints.append(episodesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: GlobalConstants.trailingOffset))
        landscapeConstraints.append(episodesLabel.bottomAnchor.constraint(equalTo: episodesTableView.topAnchor, constant: GlobalConstants.itemOffsetN))

        landscapeConstraints.append(characterInfoModule.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        landscapeConstraints.append(characterInfoModule.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: GlobalConstants.trailingOffset))
        landscapeConstraints.append(characterInfoModule.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        landscapeConstraints.append(characterInfoModule.bottomAnchor.constraint(equalTo: episodesTableView.topAnchor, constant: GlobalConstants.botOffset))


        let constraints = UIDevice.current.isLandscapeOrFlat ? landscapeConstraints : portraitConstraints
        NSLayoutConstraint.activate(constraints)
    }
}
