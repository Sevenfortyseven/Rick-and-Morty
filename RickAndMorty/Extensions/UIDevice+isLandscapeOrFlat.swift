//
//  UIDevice+isLandscapeOrFlat.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.07.23.
//

import UIKit

extension UIDevice {

    var isLandscapeOrFlat: Bool {
        return orientation.isLandscape == true || orientation.isFlat == true
    }
}
