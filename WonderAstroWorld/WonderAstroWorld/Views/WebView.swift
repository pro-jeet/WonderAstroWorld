//
//  WebView.swift
//  WonderAstroWorld
//
//  Created by JSharma on 28/05/24.
//

import Foundation
import WebKit
import SwiftUI

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}

struct WebView : UIViewRepresentable {
    var url: String

    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(url)
    }
}
