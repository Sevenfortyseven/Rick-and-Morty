//
//  CharacterInfoModule.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import UIKit


class CharacterInfoModule: UIView
{
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
   
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterImageView.roundCorners(corners: .allCorners, radius: .small)
    }
    
    private func initialize() {
//        self.backgroundColor = .backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        addSubviews()
        initializeConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(characterName)
        self.addSubview(characterImageView)
        self.addSubview(mainStack)
        mainStack.addArrangedSubview(VstackL)
        mainStack.addArrangedSubview(VstackR)
        
        VstackL.addArrangedSubview(characterStatusLabel)
        VstackL.addArrangedSubview(characterSpeciesLabel)
        VstackL.addArrangedSubview(characterGenderLabel)
        VstackL.addArrangedSubview(characterDimensionLabel)
        VstackL.addArrangedSubview(characterOriginLabel)
        
        VstackR.addArrangedSubview(characterStatus)
        VstackR.addArrangedSubview(characterSpecies)
        VstackR.addArrangedSubview(characterGender)
        VstackR.addArrangedSubview(characterDimension)
        VstackR.addArrangedSubview(characterOrigin)
   
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
    
    private var VstackL: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 5
        return stack
    }()
   
    private var VstackR: UIStackView = {
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
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(characterName.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor, constant: GlobalConstants.leadingOffset))
        constraints.append(characterName.topAnchor.constraint(equalTo: self.topAnchor))
        
        constraints.append(characterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: GlobalConstants.leadingOffset))
        constraints.append(characterImageView.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: GlobalConstants.itemOffset))
        constraints.append(characterImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: GlobalConstants.imageSizeMulti))
        constraints.append(characterImageView.widthAnchor.constraint(equalTo: characterImageView.heightAnchor))

        constraints.append(mainStack.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: GlobalConstants.itemOffset))
        constraints.append(mainStack.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor))
        constraints.append(mainStack.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
}
