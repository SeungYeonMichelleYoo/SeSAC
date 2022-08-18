//
//  WebViewController.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/08.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(destinationURL)
        
        openWebPage(url: destinationURL)
               
    }
    
    @IBAction func xmarkButtonClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func goBackButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadButtonClicked(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func goForwardButtonClicked(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    func openWebPage(url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
