//
//  Imovies.swift
//  RickAndMorty
//
//  Created by aleksandre on 26.05.22.
//

import Foundation


enum imoviesEndpoint {
    
    case transferToSite
        
    /// Edit endpoint path, transform it into URL
    func createEndpoint(with path: String) -> URL? {
        switch self {
        case .transferToSite:
            if let (season, episode) = extractSeasonAndEpisode(from: path) {
                let endpoint = "https://rick-i-morty.online/episodes/\(season)sez-\(episode)seriya"
                guard let url = URL(string: endpoint) else { return nil }
                print("URL: \(url)")
                return url
            }
            return nil
        }
    }

    func extractSeasonAndEpisode(from input: String) -> (String, String)? {
        let pattern = #"S0?(\d{1,2})E0?(\d{1,2})"#
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        if let match = regex.firstMatch(in: input, options: [], range: NSRange(input.startIndex..., in: input)) {
            let seasonRange = Range(match.range(at: 1), in: input)!
            let episodeRange = Range(match.range(at: 2), in: input)!
            var seasonNumber = String(input[seasonRange])
            var episodeNumber = String(input[episodeRange])
            if let firstChar = seasonNumber.first, firstChar == "0" {
                seasonNumber.removeFirst()
            }
            if let firstChar = episodeNumber.first, firstChar == "0" {
                episodeNumber.removeFirst()
            }
            return (seasonNumber, episodeNumber)
        } else {
            return nil
        }
    }
}
