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
    var doneBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    var definition: Definition?
    var word: String?
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wordTypeLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var exampleTitle: UILabel!
    @IBOutlet weak var wordImageView: UIImageView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    // MARK: - ViewController life-cycle
    override func updateColorsAfterThemeChange() {
        self.doneBarButtonItem.tintColor = DictionaryColors.defaut
    }
    
    override func setupUI() {
        self.addDoneBarButtonItem()
        self.loadDefinitionData()
    }
    
    // MARK: - Private funcs
    private func addDoneBarButtonItem() {
        self.doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.dismissViewController))
        self.doneBarButtonItem.tintColor = DictionaryColors.defaut
        self.navigationItem.rightBarButtonItem  = self.doneBarButtonItem
    }
    
    private func loadDefinitionData() {
        self.title = definition?.emoji ?? ""
        self.titleLabel.text = self.word ?? ""
        self.wordTypeLabel.text = self.definition?.type
        self.definitionLabel.text = self.definition?.definition
        self.exampleLabel.text = self.definition?.example
        self.exampleTitle.isHidden = self.definition?.example == "" || self.definition?.example == nil
        
        guard let image = self.definition?.image else {
            self.wordImageView.isHidden = true
            self.imageViewHeight.constant = 0
            return
        }
        
        if let url = URL(string: image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.wordImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    @objc private func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
