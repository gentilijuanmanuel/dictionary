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
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchWordTextField: MinimalisticTextField!
    @IBOutlet weak var searchWordButton: LoadingButton!
    
    // MARK: - ViewController life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addDoneButtonOnKeyboard()
        self.searchWordButton.isEnabled = false
        self.searchWordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateColorsAfterThemeChange()
    }
    
    override func updateColorsAfterThemeChange() {
        self.searchWordTextField.textColor = DictionaryColors.defaut
        self.searchWordTextField.setupStyling()
        self.doneBarButtonItem.tintColor = DictionaryColors.defaut
    }

    // MARK: - Private funcs
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        self.doneBarButtonItem.tintColor = DictionaryColors.defaut
        
        let items = [flexSpace, self.doneBarButtonItem]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.searchWordTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.searchWordTextField.resignFirstResponder()
    }
    
    func navigateToResultScreen(definition: Definition?) {
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
    
    @objc func textFieldDidChange() {
        self.searchWordButton.isEnabled = !(self.searchWordTextField.text?.isEmpty ?? true)
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
                    self.navigateToResultScreen(definition: definition?.definitions.first ?? nil)
                }
            }
        }
    }
    
}
