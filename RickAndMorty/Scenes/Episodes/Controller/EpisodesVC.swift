//
//  ViewController.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import UIKit

protocol EpisodesViewControllerDelegate: AnyObject {
    func didSelect(episode: Episode)
}


final class EpisodesViewController: BaseViewController {
    weak var delegate: EpisodesViewControllerDelegate?
    public var viewModel: EpisodesViewModel
    private lazy var searchBarModule = SearchBarModule()
    
    // MARK: -- Initialization --
    
    init(viewModel: EpisodesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // Coder is not needed in this app
        fatalError("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        initializeConstraints()
        setupTableView()
        updateUI()
        setupSearchbar()
        bindToViewModel()
        keyboardConfiguration()
    }
    
    private func addSubviews() {
        view.addSubview(episodesTableView)
        view.addSubview(searchBarModule)
        view.addSubview(episodesLabel)
    }
    
    
    private func bindToViewModel() {
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
    }
    
    // MARK: -- UI Configuration --
    
    private func updateUI() {
    }
    
    /// Dismiss keyboard  with taps on the screen
    private func keyboardConfiguration() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
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


extension EpisodesViewController: UISearchBarDelegate
{
    // MARK: -- Searchbar Configuration & Delegate Methods --
    
    private func setupSearchbar() {
        searchBarModule.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(with: searchText)
    }
}


extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource
{
    
    // MARK: -- TableView Configuration & Delegate Methods --
    
    private func setupTableView() {
        episodesTableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.identifier)
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        episodesTableView.tintColor = .secondaryColor
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.episodesStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier, for: indexPath) as! EpisodeCell
        cell.data = viewModel.getSelectedEpisode(with: indexPath)
        viewModel.paginateIfNeeded(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * GlobalConstants.tableViewCellHMulti
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(episode: viewModel.getSelectedEpisode(with: indexPath))
    }

}




extension EpisodesViewController
{
    // MARK: -- Constraints --
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()

        constraints.append(episodesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(episodesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(episodesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(episodesTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: GlobalConstants.scrollViewHMulti))
        
        constraints.append(searchBarModule.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(searchBarModule.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(searchBarModule.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        
        constraints.append(episodesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GlobalConstants.leadingOffset))
        constraints.append(episodesLabel.bottomAnchor.constraint(equalTo: episodesTableView.topAnchor, constant: GlobalConstants.itemOffsetN))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
