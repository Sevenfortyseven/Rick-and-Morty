//
//  charactersCell.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

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
        contentView.clipsToBounds = true
        addSubviews()
        initializeConstraints()
        self.roundCorners(corners: .allCorners, radius: .small)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
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
        characterImage.getImage(with: data.image)
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
        label.font = .preferredFont(forTextStyle: .title3, compatibleWith: .init(legibilityWeight: .bold))
        return label
    }()
    
    private var characterStatus: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        return label
    }()
    
    
}


extension CharactersCollectionCell
{
    // MARK: -- Constraints --
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        constraints.append(characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        constraints.append(characterImage.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(characterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        
        constraints.append(characterName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: GlobalConstants.ScrollView.leadingOffset))
        constraints.append(characterName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: GlobalConstants.ScrollView.botOffset))
        
        constraints.append(characterStatus.leadingAnchor.constraint(equalTo: characterName.leadingAnchor))
        constraints.append(characterStatus.bottomAnchor.constraint(equalTo: characterName.topAnchor, constant: GlobalConstants.ScrollView.itemPaddingN))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
