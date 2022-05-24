//
//  SearchBarModule.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import Foundation
import UIKit

class SearchBarModule: UIView
{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.addSubview(searchBar)
        self.translatesAutoresizingMaskIntoConstraints = false
        initializeConstraints()
    }
    
    
    public let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.textColor = .white
        searchBar.autocorrectionType = .no
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .searchBarBackgroundColor
//        searchBar.searchTextField.leftView?.tintColor = .purple
        return searchBar
    }()
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(searchBar.topAnchor.constraint(equalTo: self.topAnchor))
        constraints.append(searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}
