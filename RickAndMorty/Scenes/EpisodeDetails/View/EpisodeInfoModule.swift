//
//  episodeInfoModule.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import Foundation
import UIKit


class EpisodeInfoModule: UIView
{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
  
    private func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        initializeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func addSubviews() {
        self.addSubview(Vstack)
        Vstack.addArrangedSubview(episodeName)
        Vstack.addArrangedSubview(episode)
        Vstack.addArrangedSubview(airDate)
    }
    
    
    private var Vstack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 7
        stack.axis = .vertical
        return stack
    }()
    
    public var episodeName: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2, compatibleWith: .init(legibilityWeight: .bold))
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    public var episode: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .regular))
        label.textColor = .white
        return label
    }()
    
    public var airDate: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        label.textColor = .white
        return label
    }()
    
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(Vstack.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(Vstack.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(Vstack.topAnchor.constraint(equalTo: self.topAnchor))
        constraints.append(Vstack.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}
