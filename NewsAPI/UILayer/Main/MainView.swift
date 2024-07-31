//
//  MainView.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import SnapKit
import UIKit

final class MainView: UIView {
    // MARK: Views
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        var view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        view.register(HeadlineCell.self, forCellWithReuseIdentifier: HeadlineCell.identifier)
        return view
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Functions
extension MainView {
    private func layout() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
