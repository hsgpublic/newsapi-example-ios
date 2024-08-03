//
//  ArticleObjcViewController+WebView.m
//  NewsAPI
//
//  Created by 구홍석 on 8/3/24.
//

#import "ArticleObjcViewController+WebView.h"

@implementation ArticleObjcViewController (WebView)

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [[self activityIndicator] startAnimating];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [[self activityIndicator] stopAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [[self activityIndicator] stopAnimating];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(true);
}

@end
