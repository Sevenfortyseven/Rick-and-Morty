//
//  RequestError.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation


public enum RequestError: Error
{
    case decode
    case invalidURL(URL?)
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
}


extension RequestError
{
    var customMessage: String {
        switch self {
        case .decode:
            return "Error While Decoding Response"
        case .invalidURL(let url):
            return "Invalid URL: \(url?.description ?? "--")"
        case .unauthorized:
            return "Session Expired"
        default:
            return "Unknown Error"
        }
    }
}
