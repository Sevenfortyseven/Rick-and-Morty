//
//  CharacterInfoModule.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import UIKit


class CharacterInfoModule: UIView {
    private var landscapeConstraints: [NSLayoutConstraint] = []
    private var portraitConstraints: [NSLayoutConstraint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
   
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initializeConstraints()
        setNeedsLayout()
        characterImageView.roundCorners(corners: .allCorners, radius: .small)
    }
    
    private func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        addSubviews()
        initializeConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(characterName)
        self.addSubview(characterImageView)
        self.addSubview(mainStack)
        mainStack.addArrangedSubview(verticalStackL)
        mainStack.addArrangedSubview(verticalStackR)
        
        verticalStackL.addArrangedSubview(characterStatusLabel)
        verticalStackL.addArrangedSubview(characterSpeciesLabel)
        verticalStackL.addArrangedSubview(characterGenderLabel)
        verticalStackL.addArrangedSubview(characterDimensionLabel)
        verticalStackL.addArrangedSubview(characterOriginLabel)
        
        verticalStackR.addArrangedSubview(characterStatus)
        verticalStackR.addArrangedSubview(characterSpecies)
        verticalStackR.addArrangedSubview(characterGender)
        verticalStackR.addArrangedSubview(characterDimension)
        verticalStackR.addArrangedSubview(characterOrigin)
   
    }
    
    
    // MARK: -- UI Elements --
    
    
    public var characterName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title2, compatibleWith: .init(legibilityWeight: .bold))
        label.textColor = .white
        return label
    }()
    
    public var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .leading
        stack.spacing = 5
        return stack
    }()
    
    private var verticalStackL: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 5
        return stack
    }()
   
    private var verticalStackR: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 5
        return stack
    }()
    
    public var characterStatus: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        label.numberOfLines = 0
        return label
    }()
    
    private var characterStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        label.numberOfLines = 0
        label.text = "Status:"
        return label
    }()
    
    public var characterSpecies: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        label.numberOfLines = 0
        return label
    }()
    
    private var characterSpeciesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        label.numberOfLines = 0
        label.text = "Species:"
        return label
    }()
    
    public var characterGender: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        label.numberOfLines = 0
        return label
    }()
    
    private var characterGenderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        label.numberOfLines = 0
        label.text = "Gender:"
        return label
    }()
    
    public var characterOrigin: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        label.numberOfLines = 0
        return label
    }()
    
    private var characterOriginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        label.numberOfLines = 0
        label.text = "Origin:"
        return label
    }()
    
    public var characterDimension: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        label.numberOfLines = 0
        return label
    }()
 
    private var characterDimensionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        label.numberOfLines = 0
        label.text = "Dimension:"
        return label
    }()
    
    private func initializeConstraints () {
        NSLayoutConstraint.deactivate(landscapeConstraints + portraitConstraints)
        landscapeConstraints.removeAll()
        portraitConstraints.removeAll()

        
        portraitConstraints.append(characterName.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor, constant: GlobalConstants.leadingOffset))
        portraitConstraints.append(characterName.topAnchor.constraint(equalTo: self.topAnchor))
        
        portraitConstraints.append(characterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: GlobalConstants.leadingOffset))
        portraitConstraints.append(characterImageView.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: GlobalConstants.itemOffset))
        portraitConstraints.append(characterImageView.heightAnchor.constraint(equalToConstant: 150.0))
        portraitConstraints.append(characterImageView.widthAnchor.constraint(equalToConstant: 150.0))

        portraitConstraints.append(mainStack.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: GlobalConstants.itemOffset))
        portraitConstraints.append(mainStack.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor))
        portraitConstraints.append(mainStack.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor))

        landscapeConstraints.append(characterName.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        landscapeConstraints.append(characterName.topAnchor.constraint(equalTo: mainStack.topAnchor))

        landscapeConstraints.append(characterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        landscapeConstraints.append(characterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: GlobalConstants.leadingOffset))
        landscapeConstraints.append(characterImageView.heightAnchor.constraint(equalToConstant: 150.0))
        landscapeConstraints.append(characterImageView.widthAnchor.constraint(equalToConstant: 150.0))

        landscapeConstraints.append(mainStack.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: GlobalConstants.itemOffset))
        landscapeConstraints.append(mainStack.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor))


        
        let constraints = UIDevice.current.isLandscapeOrFlat ? landscapeConstraints : portraitConstraints
        NSLayoutConstraint.activate(constraints)
    }
    
    
}
