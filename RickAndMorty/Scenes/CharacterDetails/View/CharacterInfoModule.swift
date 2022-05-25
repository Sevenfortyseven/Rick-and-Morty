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
    
    private func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        initializeConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(characterNameLabel)
        self.addSubview(characterImageView)
        self.addSubview(Vstack)
        Vstack.addArrangedSubview(characterStatusLabel)
        Vstack.addArrangedSubview(characterSpeciesLabel)
        Vstack.addArrangedSubview(characterGenderLabel)
        Vstack.addArrangedSubview(characterOriginLabel)
    }
    
    
    // MARK: -- UI Elements --
    
    
    public var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var Vstack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
   
    public var characterStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    public var characterSpeciesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    public var characterGenderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    public var characterOriginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
 
    private func initializeConstraints () {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(characterNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: GlobalConstants.leadingOffset))
        constraints.append(characterNameLabel.topAnchor.constraint(equalTo: self.topAnchor))
        
        constraints.append(characterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(characterImageView.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: GlobalConstants.itemOffsetN))
//        constraints.append(characterImageView.heightAnchor.constraint(equalTo: UIScreen.main.heighta, multiplier: GlobalConstants.imageSizeMulti))
        
        constraints.append(Vstack.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor))
        constraints.append(Vstack.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: GlobalConstants.leadingOffset))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
}
