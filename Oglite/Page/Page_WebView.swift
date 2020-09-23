//
//  Page_WebView.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/4/6.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit

import WebKit
import JzOsFrameWork
import Lottie
class Page_WebView: UIViewController ,WKNavigationDelegate {
    var url:String{
        get{
            var a=JzActivity.getControlInstance.getPro("lan", "nodata")
                          if(a=="nodata"){a="English"}
                          switch a {
                          case "en":
                              return "https://simple-sensor.com"
                          case "zh-Hant":
                              return "https://simple-sensor.com"
                          case "zh-Hans":
                              return "https://simple-sensor.com"
                          case "de":
                              return "https://orange-rdks.de"
                          case "it-IT":
                              return "https://orange-like.it"
                          default:
                            return "https://simple-sensor.com"
                          }
        }
    }
    @IBOutlet var container: UIView!
    var mWebView: WKWebView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
              
    }

    override func viewWillAppear(_ animated: Bool) {
       
    }
    override func viewDidAppear(_ animated: Bool) {
        print("顯示")
        loadURL(urlString: url)
    }
    
    public func loadURL(urlString: String) {
        let url = URL(string: urlString)
        if let url = url {
            let request = URLRequest(url: url)
            // init and load request in webview.
            mWebView = WKWebView(frame: self.container.frame)
            mWebView?.navigationDelegate=self
            mWebView?.frame=self.container.frame
            if let mWebView = mWebView {
                mWebView.load(request)
                mWebView.frame=self.container.frame
                self.container.addSubview(mWebView)
                self.container.sendSubviewToBack(mWebView)
            }
        }
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
           print(error.localizedDescription)
       }
       func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
           print("Strat to load")
       }
       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           print("finish to load")
        
       }
}
