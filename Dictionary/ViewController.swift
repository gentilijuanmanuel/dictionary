//
//  ViewController.swift
//  Dictionary
//
//  Created by Juan Manuel Gentili on 1/3/18.
//  Copyright © 2018 Juan Manuel Gentili. All rights reserved.
//

import UIKit
import WebKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    var word: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.layer.cornerRadius = 5
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func search(_ sender: UIButton) {
        
        //webView.reload()
        if txtField.text != "" {
            messageLabel.text = ""
            word = txtField.text!
            let url = "https://es.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=\(word!)"
            
            let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            
            let URLObject = URL(string: encoded!)
            let request = URLSession.shared.dataTask(with: URLObject!) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    do {
                        let json = try JSONSerialization.jsonObject(
                            with: data!,
                            options: JSONSerialization.ReadingOptions.mutableContainers
                            ) as! [String: Any] //transformamos el json a un arreglo.
                        let querySubJSON = json["query"] as! [String: Any]
                        let pagesSubJSON = querySubJSON["pages"] as! [String: Any]
                        //capturamos el ID del término a buscar.
                        let pageId = pagesSubJSON.keys.first!
                        let idSubJSON = pagesSubJSON[pageId] as! [String: Any]
                        let extractHTML: String?
                        if idSubJSON["extract"] != nil {
                            extractHTML = idSubJSON["extract"] as? String
                        } else {
                            extractHTML = ""
                        }
                        DispatchQueue.main.sync(execute:{
                            if extractHTML != "" {
                                let content = "<html><body><p><font size=30>" + extractHTML! + "</font></p></body><style> p { text-align: justify; }</style></html>"
                                self.performSegue(withIdentifier: "showDetailSegue", sender: content)
                            } else {
                                self.messageLabel.text = "No hemos encontrado ningún resultado :("
                            }
                        })
                    } catch {
                        print("El procesamiento de la petición tuvo un error.")
                    }
                }
            }
            request.resume()
            
        } else {
            messageLabel.text = "Debes ingresar una palabra."
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            let secondScreen:DetailViewController = segue.destination as! DetailViewController
            secondScreen.word = self.word!
            secondScreen.content = sender as? String
        }
    }
    
    
}

