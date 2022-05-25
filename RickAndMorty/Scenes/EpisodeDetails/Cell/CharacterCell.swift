//
//  charactersCell.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import Foundation
import UIKit

class CharactersCollectionCell: UICollectionViewCell
{
    private(set) static var identifier = String(describing: CharactersCollectionCell.self)
    
    
    public var data: Character? {
        didSet {
            updateContentView()
        }
    }
    
    // MARK: -- Initialization --
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func addSubviews() {
        contentView.addSubview(characterImage)
        contentView.addSubview(characterName)
        contentView.addSubview(characterStatus)
    }
    
    private func updateContentView() {
        guard let data = data else {
            return
        }
        characterStatus.text = data.status
        characterName.text = data.name
    }
    
    // MARK: -- ContentView Configuration --
    
    
    // MARK: -- ContentView Elements --
    
    private var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var characterName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .bold))
        return label
    }()
    
    private var characterStatus: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .bold))
        return label
    }()
    
    
}


extension CharactersCollectionCell
{
    // MARK: -- Constraints --
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(characterName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(characterName.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(characterName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        
        constraints.append(characterName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: GlobalConstants.ScrollView.leadingOffset))
        constraints.append(characterName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: GlobalConstants.ScrollView.botOffset))
        
        constraints.append(characterStatus.leadingAnchor.constraint(equalTo: characterName.leadingAnchor))
        constraints.append(characterStatus.bottomAnchor.constraint(equalTo: characterName.topAnchor, constant: GlobalConstants.ScrollView.itemPadding))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
