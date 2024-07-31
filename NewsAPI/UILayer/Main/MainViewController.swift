//
//  MainViewController.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: Properties
    private let viewModel: MainViewModel
    
    // MARK: Views
    private let mainView = MainView()
    
    // MARK: Lifecycle
    init(viewModel: MainViewModel = MainViewModel()) {
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
        viewModel.fetchTopHeadlines(country: "kr")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}
