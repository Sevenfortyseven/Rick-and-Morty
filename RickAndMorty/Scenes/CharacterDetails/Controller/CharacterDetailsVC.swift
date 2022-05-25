//
//  CharactersVC.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation
import UIKit


final class CharacterDetailsViewController: UIViewController
{
    
    public var viewModel: CharacterDetailsViewModel
    
    private var characterInfoModule = CharacterInfoModule()
    
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        background.removeFromSuperview()
    }
    
    private func addSubviews() {
        view.addSubview(background)
        view.addSubview(episodesTableView)
        view.addSubview(episodesLabel)
    }
    
    private func bindToVM() {
        viewModel.reloadNeeded.bind { [unowned self] _ in
            
            DispatchQueue.main.async {
                self.episodesTableView.reloadData()
            }
        }
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
    
    private var episodesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
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


extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource
{
    
    // MARK: -- TableView Configuration & Delegate Methods
    
    private func setupTableView() {
        episodesTableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.identifier)
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.episodesStore.count)
        return viewModel.episodesStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier, for: indexPath) as! EpisodeCell
        cell.data = viewModel.getEpisode(with: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * GlobalConstants.tableViewCellHMulti
    }
}


extension CharacterDetailsViewController
{
    // MARK: -- Constraints --
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(background.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(background.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(background.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(background.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        constraints.append(episodesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(episodesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(episodesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(episodesTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: GlobalConstants.scrollViewHMultiSmall))
        
        constraints.append(episodesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GlobalConstants.leadingOffset))
        constraints.append(episodesLabel.bottomAnchor.constraint(equalTo: episodesTableView.topAnchor, constant: GlobalConstants.itemOffsetN))
        
        NSLayoutConstraint.activate(constraints)
    }
}
