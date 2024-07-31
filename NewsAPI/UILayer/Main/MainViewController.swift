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
    private var isLandscapt: Bool {
        let landscapeOrientations: [UIDeviceOrientation] = [.landscapeLeft, .landscapeRight]
        return landscapeOrientations.contains(UIDevice.current.orientation)
    }
    
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
        viewModel.fetchTopHeadlines(country: "kr")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Bind
extension MainViewController {
    private func bindView() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
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
        
        // TODO: Move to article details webview.
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let maxWidth = collectionView.frame.width
        let itemWidth = isLandscapt ? maxWidth / 3.0 : maxWidth
        return CGSize(width: itemWidth, height: 150)
    }
}
