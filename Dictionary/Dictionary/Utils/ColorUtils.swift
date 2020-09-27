//
//  ColorUtils.swift
//  Dictionary
//
//  Created by Juan Manuel Gentili on 26/09/2020.
//  Copyright © 2020 Juan Manuel Gentili. All rights reserved.
//

import UIKit

enum DictionaryColors {
    static var defaut: UIColor {
        return UIViewController().isDarkMode ? .white : .black
    }
    
    static let primary: UIColor = UIColor(hex: "#1F628EFF")!
}
