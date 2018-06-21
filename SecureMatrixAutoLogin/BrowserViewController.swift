//
//  ViewController.swift
//  SecureMatrixAutoLogin
//
//  Created by mox on 2018/06/20.
//  Copyright © 2018 mox. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var webViewParentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        webView = WKWebView(frame:CGRect(x:0, y:0, width:self.webViewParentView.bounds.size.width, height:self.webViewParentView.bounds.size.height))
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        // URL設定
        let urlString = "http://kw.kait.jp/kw/top/"
        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        let url = NSURL(string: encodedUrlString!)
        let request = NSURLRequest(url: url! as URL)
        
        webView.load(request as URLRequest)
        
        self.webViewParentView.addSubview(webView)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("読み込み完了")
        let pw = UserData.getPassword()
        let passwordObj = PasswordManager.Parse(text: pw)
        
        debugPrint(PasswordManager.ToJson(passwordObj))
        
        
        print(webView.title as Any)
        print(webView.url as Any)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

