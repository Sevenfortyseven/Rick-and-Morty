//
//  CellVM.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation


struct EpisodeCellViewModel
{
    
    var episodeName: String
    var airDate: String
    var episode: String
    
    init(episodeModel: Episode) {
        self.episode = episodeModel.episode
        self.airDate = episodeModel.airDate
        self.episodeName = episodeModel.name
    }
}
