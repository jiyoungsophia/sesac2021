//
//  WebViewController.swift
//  SeSAC_04Week
//
//  Created by 양지영 on 2021/10/19.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

//    var destinationURL: String = "https://www.daum.net"
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        openWebPage(to: destinationURL)
        searchBar.delegate = self
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
    
    func openWebPage(to urlStr: String) {
        guard let url = URL(string: urlStr) else {
            print("invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    
    
}

extension WebViewController: UISearchBarDelegate{
    // 서치바에서 검색 리턴키 클릭
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let url = URL(string: searchBar.text ?? "" ) else {
            print("error")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }

//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        openWebPage(to: searchBar.text!)
//    }

}
