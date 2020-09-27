//
//  LoadingButton.swift
//  Dictionary
//
//  Created by Juan Manuel Gentili on 25/09/2020.
//  Copyright © 2020 Juan Manuel Gentili. All rights reserved.
//

import UIKit

class LoadingButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            self.backgroundColor = self.isEnabled ? DictionaryColors.primary : .gray
        }
    }
    
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
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
        self.setupColors()
        self.setupRoundedCorners()
    }
    
    func setupColors() {
        self.backgroundColor = DictionaryColors.primary
        self.tintColor = .white
    }
    
    func setupRoundedCorners() {
        self.layer.cornerRadius = 10
    }
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func hideLoading() {
        self.setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
