//
//  DetailViewController.swift
//  Dictionary
//
//  Created by Juan Manuel Gentili on 1/3/18.
//  Copyright © 2018 Juan Manuel Gentili. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var content: String?
    var word: String?

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = word!
        webView.loadHTMLString(content!, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
