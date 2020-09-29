//
//  ViewController.swift
//  Dictionary
//
//  Created by Juan Manuel Gentili on 12/09/2020.
//  Copyright © 2020 Juan Manuel Gentili. All rights reserved.
//

import UIKit

class WordSearchViewController: BaseViewController {
    
    // MARK: - Properties
    var doneBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    var clearWordBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchWordTextField: MinimalisticTextField!
    @IBOutlet weak var searchWordButton: LoadingButton!
    
    // MARK: - ViewController life-cycle    
    override func updateColorsAfterThemeChange() {
        self.searchWordTextField.textColor = DictionaryColors.defaut
        self.searchWordTextField.setupStyling()
        self.doneBarButtonItem.tintColor = DictionaryColors.defaut
        self.clearWordBarButtonItem.tintColor = DictionaryColors.defaut
    }
    
    override func setupUI() {
        self.addButtonsOnKeyboard()
        self.searchWordButton.isEnabled = false
        self.searchWordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }

    // MARK: - Private funcs
    private func addButtonsOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        self.doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        self.doneBarButtonItem.tintColor = DictionaryColors.defaut
        
        self.clearWordBarButtonItem = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(self.clearButtonAction))
        self.clearWordBarButtonItem.tintColor = DictionaryColors.defaut
        
        let items = [self.clearWordBarButtonItem, flexSpace, self.doneBarButtonItem]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.searchWordTextField.inputAccessoryView = doneToolbar
    }
    
    private func navigateToResultScreen(definition: Definition?) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "WordResultViewController")
        
        guard let wordResultViewController = newViewController as? WordResultViewController else {
            return
        }
        
        let newNavigationController = UINavigationController.init(rootViewController: wordResultViewController)
        
        wordResultViewController.definition = definition
        wordResultViewController.word = self.searchWordTextField.text
        
        self.present(newNavigationController, animated: true, completion: nil)
    }
    
    @objc private func textFieldDidChange() {
        self.searchWordButton.isEnabled = !(self.searchWordTextField.text?.isEmpty ?? true)
    }
    
    @objc private func doneButtonAction() {
        self.searchWordTextField.resignFirstResponder()
    }
    
    @objc private func clearButtonAction() {
        self.searchWordTextField.text = ""
        self.searchWordButton.isEnabled = false
    }
    
    // MARK: - IBActions
    @IBAction func searchWordButtonPressed(_ sender: UIButton) {
        self.searchWordButton.showLoading()
        NetworkManager.shared.searchDefinition(word: self.searchWordTextField.text!) { definition, error in
            DispatchQueue.main.async {
                self.searchWordButton.hideLoading()
                if let error = error {
                    print(error)
                    return
                } else {
                    self.navigateToResultScreen(definition: definition?.definitions?.first ?? nil)
                }
            }
        }
    }
    
}
