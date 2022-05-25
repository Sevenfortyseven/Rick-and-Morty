//
//  UIImage+.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import Foundation
import UIKit


extension UIImageView
{
    
    /// Fetch Image with given urlString
    private func getImageData(with urlString: String) async -> UIImage {
        self.image = nil
        
        if let imageData = ImageCache.getData(with: urlString) {
            self.image = UIImage(data: imageData)
        }
        
        let url = URL(string: urlString)
        guard let url = url else {
            return UIImage(named: ImageStore.placeholderImg.rawValue)!
        }
        let request = URLRequest(url: url)
        
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let fetchedImage = UIImage(data: data) {
                ImageCache.setData(data, with: urlString)
                return fetchedImage
            }
            
        } catch let error {
       
            print("Error while fetching image: \(error)")
        }
        return UIImage(named: ImageStore.placeholderImg.rawValue)!
    }
    
    
    public func getImage(with urlString: String) {
        Task(priority: .background) {
            let image = await self.getImageData(with: urlString)
            self.image = image
            
        }
    }
}
