//
//  DataSourceViewController.swift
//  AppCentNew
//
//  Created by ArifOk on 15.06.2021.
//

import UIKit
import WebKit

class DataSourceViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var url: URL!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.title = "Data Source"
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }

}

