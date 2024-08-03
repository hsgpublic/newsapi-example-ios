//
//  ArticleObjcViewController.m
//  NewsAPI
//
//  Created by 구홍석 on 8/3/24.
//

#import "ArticleObjcViewController.h"

@implementation ArticleObjcViewController

@synthesize webView;

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.systemBackgroundColor];
    [self setupWebView];
    [self setupActivityIndicator];
}

- (void)viewWillAppear:(BOOL)animated {
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:articleUrl];
    [self setTitle:articleTitle];
    [[self navigationController] setNavigationBarHidden:NO];
    [[self webView] loadRequest:urlRequest];
}

- (void)setupWebView {
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero
                                      configuration:configuration];
    [self setWebView:webView];
    [[self view] addSubview:webView];
    
    UILayoutGuide *safeGuide = self.view.safeAreaLayoutGuide;
    [webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[webView.leadingAnchor constraintEqualToAnchor:safeGuide.leadingAnchor
                                           constant:0] setActive:YES];
    [[webView.trailingAnchor constraintEqualToAnchor:safeGuide.trailingAnchor
                                            constant:0] setActive:YES];
    [[webView.topAnchor constraintEqualToAnchor:safeGuide.topAnchor
                                       constant:0] setActive:YES];
    [[webView.bottomAnchor constraintEqualToAnchor:safeGuide.bottomAnchor
                                          constant:0] setActive:YES];
    [webView setNavigationDelegate:self];
}

- (void)setupActivityIndicator {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    [self setActivityIndicator:activityIndicator];
    [self.view addSubview:activityIndicator];
    
    [activityIndicator setHidesWhenStopped:YES];
    [activityIndicator setCenter:self.view.center];
}

#pragma mark - Functions
- (void)setupTitle:(NSString *)title url:(NSURL *)url {
    articleTitle = title;
    articleUrl = url;
}

@end
