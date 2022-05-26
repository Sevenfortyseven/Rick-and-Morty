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
            var editedPath = path
            editedPath.insert("/", at: editedPath.index(editedPath.startIndex, offsetBy: 3))
            let endpoint = "https://www.imovies.cc/ka/movies/42453/Rick-and-Morty/\(editedPath)/GEO/HIGH"
            guard let url = URL(string: endpoint) else { return nil }
            return url
        }
    }
    
}



