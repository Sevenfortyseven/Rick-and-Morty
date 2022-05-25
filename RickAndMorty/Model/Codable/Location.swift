//
//  Location.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation


struct Location: Codable
{
    let id: Int?
    let name: String
    let type: String?
    let dimension: String?
    let residents: [String]?
    let url: String
    let created: String?
}


extension Location
{
    struct NetworkResponse: Codable {
        let info: Info
        let results: [Location]
    }
}
