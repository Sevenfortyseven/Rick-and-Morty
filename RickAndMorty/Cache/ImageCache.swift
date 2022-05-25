//
//  ImageCache.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import Foundation


struct ImageCache
{
    
    // A simple cache
    
    private static var imageData = [String: Data]()
    
    
    public static func setData(_ data: Data?, with urlString: String) {
        imageData[urlString] = data
    }
    
    public static func getData(with urlString: String) -> Data? {
        return imageData[urlString]
    }
    
}
