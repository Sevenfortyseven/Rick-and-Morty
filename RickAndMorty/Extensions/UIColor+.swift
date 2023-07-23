//
//  UIColor+.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import UIKit


extension UIColor{

    static var tableViewBackgroundColor: UIColor {
        return self.init(named: "tableview_background_color")!
    }
    
    static var searchBarBackgroundColor: UIColor {
        return self.init(named: "searchbar_background_color")!
    }

    static var backgroundColor: UIColor {
        return self.init(named: "primary_color")!
    }

    static var secondaryColor: UIColor {
        return self.init(named: "secondary_color")!
    }

    static var accentColor: UIColor {
        return self.init(named: "accent_color")!
    }
}
