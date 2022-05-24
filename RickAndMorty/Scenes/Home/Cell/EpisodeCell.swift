//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation
import UIKit


final class EpisodeCell: UITableViewCell
{
    private(set) static var identifier = String(describing: EpisodeCell.self)
    
    // MARK: -- Initialization --
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: EpisodeCell.identifier)
        addSubviews()
        initializeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func addSubviews() {
        
    }
    
    // MARK: -- ContentView Configuration --
    
    
    // MARK: -- Contentview Elements --
    
    
    
}


extension EpisodeCell
{
    
    // MARK: -- Constraints --
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
