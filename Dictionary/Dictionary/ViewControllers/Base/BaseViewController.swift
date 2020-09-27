//
//  BaseViewController.swift
//  Dictionary
//
//  Created by Juan Manuel Gentili on 26/09/2020.
//  Copyright © 2020 Juan Manuel Gentili. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateColorsAfterThemeChange()
    }
    
    func updateColorsAfterThemeChange() {
        
    }
}
