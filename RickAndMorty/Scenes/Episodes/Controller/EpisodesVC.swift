//
//  ViewController.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import UIKit

final class EpisodesViewController: UIViewController
{
    
    public var viewModel: EpisodesViewModel
    
    
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
        updateUI()
        setupTableView()
        bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
  
    
    private func addSubviews() {
        view.addSubview(background)
        view.addSubview(episodesTableView)
    }
    
    
    private func bindToViewModel() {
        viewModel.reloadNeeded.bind { [unowned self] _ in
            DispatchQueue.main.async {
                self.episodesTableView.reloadData()
            }
          
        }
    }
    
    // MARK: -- UI Configuration --
    
    private func updateUI() {
        view.backgroundColor = .white
    }
    
    
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
        return viewModel.episodeCellVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier, for: indexPath) as! EpisodeCell
        cell.cellViewModel = viewModel.getCellVM(with: indexPath)
        viewModel.paginateIfNeeded(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * GlobalConstants.tableViewCellHMulti
    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        // Check if user scrolls to the botto of the scrollView to paginate
//        let position = scrollView.contentOffset.y
//        if position > (episodesTableView.contentSize.height - 150 - scrollView.frame.size.height) {
//            print("Pagination needed")
//        }
//    }
    
}




extension EpisodesViewController
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
        constraints.append(episodesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(episodesTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: GlobalConstants.tableViewHeightMult))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
