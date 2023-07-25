//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import UIKit


final class EpisodeCell: UITableViewCell
{
    private(set) static var identifier = String(describing: EpisodeCell.self)
    private var landscapeConstraints: [NSLayoutConstraint] = []
    private var portraitConstraints: [NSLayoutConstraint] = []

    public var data: Episode? {
        didSet {
            updateContentView()
        }
    }
    
    // MARK: -- Initialization --
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: EpisodeCell.identifier)
        addSubviews()
        initializeConstraints()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initializeConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(namelabel)
        contentView.addSubview(episodeLabel)
        contentView.addSubview(airDateLabel)
    }
    
    /// Updates contetnview  accordingly after receiving data from viewmodel
    private func updateContentView() {
        DispatchQueue.main.async {
            guard let dataSource = self.data else { return }
            self.namelabel.text = dataSource.name
            self.airDateLabel.text = dataSource.airDate
            self.episodeLabel.text = dataSource.episode
        }
    }
    
    // MARK: -- ContentView Configuration --
    
    
    private func updateUI() {
        backgroundColor = .secondaryColor
        selectionStyle = .none
    }
    
    // MARK: -- Contentview Elements --
    
    private var namelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3, compatibleWith: .init(legibilityWeight: .bold))
        label.textColor = .white
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private var episodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .bold))
        label.textColor = .lightGray
        return label
    }()
    
    private var airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote, compatibleWith: .init(legibilityWeight: .bold))
        label.textColor = .white
        return label
    }()
    
}


extension EpisodeCell
{
    
    // MARK: -- Constraints --
    
    private func initializeConstraints() {
          NSLayoutConstraint.deactivate(landscapeConstraints + portraitConstraints)
          landscapeConstraints.removeAll()
          portraitConstraints.removeAll()

          portraitConstraints.append(namelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: GlobalConstants.ScrollView.leadingOffset))
          portraitConstraints.append(namelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: GlobalConstants.ScrollView.topOffset))

          portraitConstraints.append(airDateLabel.leadingAnchor.constraint(equalTo: namelabel.leadingAnchor))
          portraitConstraints.append(airDateLabel.topAnchor.constraint(equalTo: namelabel.bottomAnchor, constant: GlobalConstants.ScrollView.itemPadding))

          portraitConstraints.append(episodeLabel.leadingAnchor.constraint(equalTo: namelabel.trailingAnchor, constant: GlobalConstants.ScrollView.itemPadding))
          portraitConstraints.append(episodeLabel.firstBaselineAnchor.constraint(equalTo: namelabel.firstBaselineAnchor))
          portraitConstraints.append(episodeLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: GlobalConstants.ScrollView.trailingOffset))

          landscapeConstraints.append(namelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: GlobalConstants.ScrollView.leadingOffset))
          landscapeConstraints.append(namelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: GlobalConstants.ScrollView.topOffset))

          landscapeConstraints.append(airDateLabel.leadingAnchor.constraint(equalTo: namelabel.trailingAnchor, constant: GlobalConstants.ScrollView.itemPadding))
          landscapeConstraints.append(airDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: GlobalConstants.ScrollView.topOffset))

          landscapeConstraints.append(episodeLabel.leadingAnchor.constraint(equalTo: airDateLabel.trailingAnchor, constant: GlobalConstants.ScrollView.itemPadding))
          landscapeConstraints.append(episodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: GlobalConstants.ScrollView.topOffset))

          let constraints = UIDevice.current.isLandscapeOrFlat ? landscapeConstraints : portraitConstraints
          NSLayoutConstraint.activate(constraints)
      }
    
}
