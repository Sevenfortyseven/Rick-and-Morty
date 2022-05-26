//
//  UIView+.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import UIKit

extension UIView
{
    
    enum CurveRadius {
        case small, medium
    }
    
    /// Apply curves to custom corners
    func roundCorners(corners: UIRectCorner, radius: CurveRadius) {
        var r = CGFloat()
        switch radius {
        case .small:
            r = self.frame.width / 30
        case .medium:
            r = self.frame.width / 25
        }
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: r, height: r))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}


