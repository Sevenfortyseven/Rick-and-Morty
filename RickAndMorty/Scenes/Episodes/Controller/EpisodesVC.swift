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
    private var landscapeConstraints: [NSLayoutConstraint] = []
    private var portraitConstraints: [NSLayoutConstraint] = []
    
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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
          super.viewWillTransition(to: size, with: coordinator)
          initializeConstraints()
      }
    
    private func addSubviews() {
        view.addSubview(episodesTableView)
        view.addSubview(searchBarModule)
        view.addSubview(episodesLabel)
        view.addSubview(spinner)
    }
    
    
    private func bindToViewModel() {
        viewModel.reloadNeeded.bind { [unowned self] _ in
            DispatchQueue.main.async {
                self.episodesTableView.reloadData()
            }
        }
        viewModel.internetConnection.bind { [unowned self] connection in
            if connection == false {
                alertManger.alert(show: .networkError, on: self)
            }
        }
        viewModel.isLoading.bind { [unowned self] isFetching in
            DispatchQueue.main.async {
                if isFetching {
                    self.spinner.startAnimating()
                } else {
                    self.spinner.stopAnimating()
                }
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

    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .accentColor
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
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
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(episode: viewModel.getSelectedEpisode(with: indexPath))
    }

}




extension EpisodesViewController
{
    // MARK: -- Constraints --
    private func initializeConstraints() {
        // Clear existing constraints
        NSLayoutConstraint.deactivate(landscapeConstraints + portraitConstraints)
        landscapeConstraints.removeAll()
        portraitConstraints.removeAll()

        portraitConstraints.append(episodesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        portraitConstraints.append(episodesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        portraitConstraints.append(episodesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        portraitConstraints.append(episodesTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: GlobalConstants.scrollViewHMulti))

        portraitConstraints.append(searchBarModule.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        portraitConstraints.append(searchBarModule.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        portraitConstraints.append(searchBarModule.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))

        portraitConstraints.append(episodesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GlobalConstants.leadingOffset))
        portraitConstraints.append(episodesLabel.bottomAnchor.constraint(equalTo: episodesTableView.topAnchor, constant: GlobalConstants.itemOffsetN))

        portraitConstraints.append(spinner.centerXAnchor.constraint(equalTo: episodesTableView.centerXAnchor))
        portraitConstraints.append(spinner.centerYAnchor.constraint(equalTo: episodesTableView.centerYAnchor))

        landscapeConstraints.append(episodesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        landscapeConstraints.append(episodesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        landscapeConstraints.append(episodesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        landscapeConstraints.append(episodesTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6))

        landscapeConstraints.append(searchBarModule.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        landscapeConstraints.append(searchBarModule.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        landscapeConstraints.append(searchBarModule.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))

        landscapeConstraints.append(episodesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: GlobalConstants.leadingOffset))
        landscapeConstraints.append(episodesLabel.bottomAnchor.constraint(equalTo: episodesTableView.topAnchor, constant: GlobalConstants.itemOffsetN))

        landscapeConstraints.append(spinner.centerXAnchor.constraint(equalTo: episodesTableView.centerXAnchor))
        landscapeConstraints.append(spinner.centerYAnchor.constraint(equalTo: episodesTableView.centerYAnchor))


        let constraints = UIDevice.current.isLandscapeOrFlat ? landscapeConstraints : portraitConstraints
        NSLayoutConstraint.activate(constraints)
    }
    
}
