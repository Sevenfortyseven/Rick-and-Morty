//
//  RangeReplaceableCollection+.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import Foundation


extension RangeReplaceableCollection where Self: StringProtocol {
   
    /// Filter a string and return only  whole numbers
    var digits: Self { filter(\.isWholeNumber) }
}

