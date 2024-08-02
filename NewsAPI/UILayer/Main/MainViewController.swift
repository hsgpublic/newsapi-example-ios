//
//  MainViewController.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import Combine
import UIKit

final class MainViewController: UIViewController {
    // MARK: Properties
    private let viewModel: MainViewModel
    private var cancellables = Set<AnyCancellable>()
    
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
        bindView()
        bindViewModel()
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        guard let flowLayout = mainView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
}

// MARK: - Bind
extension MainViewController {
    private func bindView() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.refreshControl?.addTarget(
            self,
            action: #selector(refresh),
            for: .valueChanged
        )
    }
    
    private func bindViewModel() {
        viewModel.$headlineCellDatas
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.mainView.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: Functions
extension MainViewController {
    @objc private func refresh() {
        viewModel.fetchTopHeadlines(country: "kr")
        mainView.collectionView.refreshControl?.endRefreshing()
    }
    
    private func moveToArticle(title: String, urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let articleViewModel = ArticleViewModel(title: title, url: url)
        let articleViewController = ArticleViewController(viewModel: articleViewModel)
        navigationController?.pushViewController(articleViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.headlineCellDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        lazy var defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
        guard let cellData = viewModel.headlineCellData(at: indexPath.item) else {
            return defaultCell
        }
        guard let headlineCell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCell.identifier, for: indexPath) as? HeadlineCell else {
            return defaultCell
        }
        
        headlineCell.setup(data: cellData)
        return headlineCell
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellData = viewModel.headlineCellData(at: indexPath.item) else {
            return
        }
        
        moveToArticle(title: cellData.title, urlString: cellData.articleURL)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let horizontalItemCount: Int = UIDevice.current.orientation.isLandscape ? 3 : 1
        let horizontalEdgeInset: CGFloat = (flowLayout?.sectionInset.left ?? 0) + (flowLayout?.sectionInset.right ?? 0)
        let widthSpacing = (flowLayout?.minimumInteritemSpacing ?? 0) * CGFloat(horizontalItemCount - 1)
        let maxWidth = collectionView.frame.width - horizontalEdgeInset - widthSpacing
        let itemWidth = maxWidth / CGFloat(horizontalItemCount)
        return CGSize(width: itemWidth, height: 130)
    }
}
