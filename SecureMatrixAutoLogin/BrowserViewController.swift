//
//  ViewController.swift
//  SecureMatrixAutoLogin
//
//  Created by mox on 2018/06/20.
//  Copyright © 2018 mox. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, UITextFieldDelegate {
    
    var webView: WKWebView!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var webViewParentView: UIView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        urlTextField.delegate = self
        
        webView = WKWebView(frame:CGRect(x:0, y:0, width:self.webViewParentView.bounds.size.width, height:self.webViewParentView.bounds.size.height))
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        
        loadWebView("http://kw.kait.jp/kw/top/")
        
        self.webViewParentView.addSubview(webView)
        
        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    @IBAction func reloadTaped(_ sender: UIButton) {
        webView.reload()
    }
    
    deinit{
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "loading")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
        }else if keyPath == "loading"{
            UIApplication.shared.isNetworkActivityIndicatorVisible = webView.isLoading
            if webView.isLoading{
                progressBar.setProgress(0.1, animated: true)
            }else{
                progressBar.setProgress(0.0, animated: false)
            }
        }
    }
    
    func loadWebView(_ urlString: String){
        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        let url = NSURL(string: encodedUrlString!)
        let request = NSURLRequest(url: url! as URL)
        
        webView.load(request as URLRequest)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTextField.text = webView.url?.absoluteString
        
        let pw = UserData.getPassword()
        let passwordObj = PasswordManager.Parse(text: pw)
        let passwordInfoJson = PasswordManager.ToJson(passwordObj)
        
        let runScript = """
        (function() {
        let secureMatrixTdDOM = document.querySelectorAll(".allMatrix td");
        if (secureMatrixTdDOM === undefined || secureMatrixTdDOM == null)
        return;
        let secureMatrixDom = [],
        secureMatrix = [],
        password = \(passwordInfoJson);
        secureMatrixTdDOM.forEach(function(value) {
        if (value.innerText.length === 1) {
        secureMatrixDom.push(value);
        secureMatrix.push(value.innerText);
        }
        });
        
        let passwordText = "";
        password.forEach(function(value) {
        if (value.IsMatrix) {
        let text = secureMatrix[value.Number];
        passwordText += text;
        } else passwordText += value.Number;
        });
        
        let passwordInput = document.querySelector("form[name=GUID] input[type=password]");
        if (passwordInput === undefined || passwordInput == null)
        alert("Not found secureMatrix password input.");
        passwordInput.value = passwordText;
        })();
        """
        
        webView.evaluateJavaScript(runScript, completionHandler: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let urlBarText = textField.text!
        if urlBarText.starts(with: "http://") || urlBarText.starts(with: "https://") {
            loadWebView(urlBarText)
        }else{
            let encoded = urlBarText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            loadWebView("https://google.com/search?q=" + encoded)
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

