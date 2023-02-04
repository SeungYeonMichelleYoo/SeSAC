//
//  WebViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by SeungYeon Yoo on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL: String = "https://www.apple.com" //App Transport Security Settings
    //http에 대한 사이트는 대부분 차단함
    
    override func viewDidLoad() {
        super.viewDidLoad()

        openWebPage(url: destinationURL)
        searchBar.delegate = self
    }
 
    @IBAction func goBackButtonClicked(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadButtonClicked(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func goForwardButtonClicked(_ sender: Any) {
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

extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(url: searchBar.text!)
    }
}
//textDidChange: 실시간 검색.
