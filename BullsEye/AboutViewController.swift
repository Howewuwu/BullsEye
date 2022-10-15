//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Howe on 2022/8/15.
//

import UIKit
import WebKit // 加入網頁時需新增 import WebKit



class AboutViewController: UIViewController {
    
    @IBOutlet weak var webView : WKWebView! // 連接 Main 上的 webView 型態為 WKWebView

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 做新頁面可參考 https://www.raywenderlich.com/5993-your-first-ios-and-uikit-app/lessons/35
        // 做 webview 可參考 https://www.raywenderlich.com/5993-your-first-ios-and-uikit-app/lessons/43
        // webView 需要用一個 method 叫 load 來讀取，而 load 需要一個 URLRequest 來做參數，URLRequest 需要一個”URL 路徑“來做定位，而這個路徑則是使用 Bundle 來做綁定。
        if let htmlPath = Bundle.main.path(forResource: "BullsEye", ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            let request = URLRequest(url: url)
            webView.load(request)
        }

       }
    
    // 做關閉這個頁面的 button.
    @IBAction func closeView(){
        dismiss(animated: true, completion: nil)
    }
    
   

    
 
}
