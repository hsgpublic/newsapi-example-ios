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
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        return view
    }()
    var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: configuration)
        return view
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layout()
        bindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Bind
extension ArticleView {
    private func bindView() {
        webView.navigationDelegate = self
    }
}

// MARK: Functions
extension ArticleView {
    private func layout() {
        addSubview(webView)
        addSubview(activityIndicator)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func loadArticle(urlRequest: URLRequest) {
        if webView.isLoading {
            webView.stopLoading()
        }
        webView.load(urlRequest)
    }
}

// MARK: - WKNavigationDelegate
extension ArticleView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if activityIndicator.isAnimating == false {
            activityIndicator.startAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}
