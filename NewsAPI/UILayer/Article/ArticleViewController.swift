//
//  ArticleViewController.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import UIKit

final class ArticleViewController: UIViewController {
    // MARK: Properties
    private let viewModel: ArticleViewModel
    
    // MARK: Views
    private let mainView = ArticleView()
    
    // MARK: Lifecycle
    init(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        loadArticle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = viewModel.title
        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - Bind
extension ArticleViewController {
    private func bindView() {
        
    }
}

// MARK: - Functions
extension ArticleViewController {
    private func loadArticle() {
        mainView.loadArticle(urlRequest: viewModel.urlRequest)
    }
}
