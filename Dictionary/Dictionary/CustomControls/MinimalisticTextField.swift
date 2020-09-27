//
//  MinimalisticTextField.swift
//  Dictionary
//
//  Created by Juan Manuel Gentili on 26/09/2020.
//  Copyright © 2020 Juan Manuel Gentili. All rights reserved.
//

import UIKit

class MinimalisticTextField: UITextField {
    
    ///this init method is called when you add the button on your ViewController code
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupStyling()
    }
    
    ///this init method is called when you add the button on your storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupStyling()
    }
    
    func setupStyling() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height + 10, width: self.frame.width, height: 0.5)
        bottomLine.backgroundColor = DictionaryColors.defaut.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        
        UITextField.appearance().tintColor = DictionaryColors.primary
    }
}
