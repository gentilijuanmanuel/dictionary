//
//  WordResultViewController.swift
//  Dictionary
//
//  Created by Juan Manuel Gentili on 13/09/2020.
//  Copyright © 2020 Juan Manuel Gentili. All rights reserved.
//

import UIKit

class WordResultViewController: BaseViewController {
    
    // MARK: - Properties
    var definition: Definition?
    var word: String?
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wordTypeLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var wordImageView: UIImageView!
    
    // MARK: - ViewController life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Private funcs
    func setupUI() {
        self.titleLabel.text = self.word ?? "" + " " + definition!.emoji
        self.wordTypeLabel.text = self.definition?.type
        self.definitionLabel.text = self.definition?.definition
        self.exampleLabel.text = self.definition?.example
        
        if let url = URL(string: self.definition!.image) {
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf:url) {
                    DispatchQueue.main.async {
                        self.wordImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}