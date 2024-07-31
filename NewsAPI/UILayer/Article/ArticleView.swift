//
//  ArticleView.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import SnapKit
import UIKit
import WebKit

final class ArticleView: UIView {
    // MARK: Views
    var indicator: UIActivityIndicatorView? = nil
    var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: configuration)
        return view
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Functions
extension ArticleView {
    private func layout() {
        addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func loadArticle(url: URL) {
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
