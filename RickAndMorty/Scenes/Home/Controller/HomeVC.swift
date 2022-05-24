//
//  ViewController.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import UIKit

final class HomeViewController: UIViewController
{
    
    public var viewModel: HomeViewModel
    
    
    // MARK: -- Initialization --
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        initializeConstraints()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(background)
    }
    
    // MARK: -- UI Configuration --
    
    private func updateUI() {
        view.backgroundColor = .white
    }
    
    
    // MARK: -- UI Elements --
    
    private var background: UIImageView = {
        let background = UIImageView()
        background.contentMode = .scaleAspectFill
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = UIImage(named: ImageStore.mainBackground.rawValue)
        return background
    }()
}




extension HomeViewController
{
    // MARK: -- Constraints --
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(background.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(background.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(background.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(background.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
