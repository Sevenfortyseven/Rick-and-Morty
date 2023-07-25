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
    private var landscapeConstraints: [NSLayoutConstraint] = []
    private var portraitConstraints: [NSLayoutConstraint] = []
    
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

    override func layoutSubviews() {
        super.layoutSubviews()
        initializeConstraints()
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
           // Clear existing constraints
           NSLayoutConstraint.deactivate(landscapeConstraints + portraitConstraints)
           landscapeConstraints.removeAll()
           portraitConstraints.removeAll()

           portraitConstraints.append(characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
           portraitConstraints.append(characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
           portraitConstraints.append(characterImage.topAnchor.constraint(equalTo: contentView.topAnchor))
           portraitConstraints.append(characterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))

           portraitConstraints.append(characterName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: GlobalConstants.ScrollView.leadingOffset))
           portraitConstraints.append(characterName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: GlobalConstants.ScrollView.botOffset))

           portraitConstraints.append(characterStatus.leadingAnchor.constraint(equalTo: characterName.leadingAnchor))
           portraitConstraints.append(characterStatus.bottomAnchor.constraint(equalTo: characterName.topAnchor, constant: GlobalConstants.ScrollView.itemPaddingN))

           // Landscape constraints
           landscapeConstraints.append(characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
           landscapeConstraints.append(characterImage.topAnchor.constraint(equalTo: contentView.topAnchor))
           landscapeConstraints.append(characterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
           landscapeConstraints.append(characterImage.widthAnchor.constraint(equalTo: contentView.heightAnchor))

           landscapeConstraints.append(characterName.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: GlobalConstants.ScrollView.itemPadding))
           landscapeConstraints.append(characterName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: GlobalConstants.ScrollView.itemPadding))

           landscapeConstraints.append(characterStatus.leadingAnchor.constraint(equalTo: characterName.leadingAnchor))
           landscapeConstraints.append(characterStatus.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: GlobalConstants.ScrollView.itemPaddingN))

           let constraints = UIDevice.current.isLandscapeOrFlat ? landscapeConstraints : portraitConstraints
           NSLayoutConstraint.activate(constraints)
       }

    
}
