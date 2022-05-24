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
    
    public var cellViewModel: EpisodeCellViewModel? {
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
    }
    
    private func addSubviews() {
        contentView.addSubview(namelabel)
        contentView.addSubview(episodeLabel)
        contentView.addSubview(airDateLabel)
    }
    
    /// Updates contetnview  accordingly after receiving data from viewmodel
    private func updateContentView() {
        DispatchQueue.main.async {
            guard let dataSource = self.cellViewModel else { return }
            self.namelabel.text = dataSource.episodeName
            self.airDateLabel.text = dataSource.airDate
            self.episodeLabel.text = dataSource.episode
        }
    }
    
    // MARK: -- ContentView Configuration --
    
    
    private func updateUI() {
        backgroundColor = .tableViewBackgroundColor
        selectionStyle = .none
    }
    
    // MARK: -- Contentview Elements --
    
    private var namelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private var episodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private var airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
}


extension EpisodeCell
{
    
    // MARK: -- Constraints --
    
    private func initializeConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(namelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: GlobalConstants.TableView.leadingOffset))
        constraints.append(namelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: GlobalConstants.TableView.topOffset))
        
        constraints.append(airDateLabel.leadingAnchor.constraint(equalTo: namelabel.leadingAnchor))
        constraints.append(airDateLabel.topAnchor.constraint(equalTo: namelabel.bottomAnchor, constant: GlobalConstants.TableView.itemPadding))
        
        constraints.append(episodeLabel.leadingAnchor.constraint(equalTo: namelabel.trailingAnchor, constant: GlobalConstants.TableView.itemPadding))
        constraints.append(episodeLabel.firstBaselineAnchor.constraint(equalTo: namelabel.firstBaselineAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
