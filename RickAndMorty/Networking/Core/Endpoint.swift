//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation

protocol Endpoint
{
    
    var scheme: String { get }
    
    var host: String { get }
    
    var path: String { get }
    
    var queryParams: [URLQueryItem]? { get }
    
    var body: [String: String]? { get }
    
    var header: [String: String]? { get }
    
    var method: RequestMethod { get }
    
}


