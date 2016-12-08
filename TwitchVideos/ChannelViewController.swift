//
//  ChannelViewController.swift
//  TwitchVideos
//
//  Created by Administrator on 08.12.16.
//  Copyright © 2016 Loginov Anton. All rights reserved.
//

import UIKit
import WebKit

class ChannelViewController: UIViewController {

    var stream: Stream!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)
        let urlString = baseEmbedURL + stream.broadcasterName + embedURL
        
        if let url = URL(string: urlString) {
        let request = URLRequest(url: url)
            webView.load(request)
        }
    }

}
