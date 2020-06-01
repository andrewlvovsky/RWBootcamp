//
//  RGBWikiController.swift
//  RGB Color Picker
//
//  Created by Andrew Lvovsky on 5/31/20.
//  Copyright © 2020 Andrew Lvovsky. All rights reserved.
//

import UIKit
import WebKit

class RGBWikiController: UIViewController {
    
    @IBOutlet weak var webView : WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://en.wikipedia.org/wiki/RGB_color_model") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }

}
