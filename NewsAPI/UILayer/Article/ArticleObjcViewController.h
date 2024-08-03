//
//  ArticleObjcViewController.h
//  NewsAPI
//
//  Created by 구홍석 on 8/3/24.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleObjcViewController : UIViewController <WKNavigationDelegate> {
    NSString *articleTitle;
    NSURL *articleUrl;
}

@property (nonatomic) UIActivityIndicatorView *activityIndicator;
@property (nonatomic) WKWebView *webView;

- (void)setupTitle:(NSString *)title url:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
