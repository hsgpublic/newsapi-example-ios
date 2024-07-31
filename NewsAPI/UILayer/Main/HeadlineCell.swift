//
//  HeadlineCell.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import SnapKit
import UIKit

final class HeadlineCell: UICollectionViewCell {
    // MARK: Constants
    static let identifier = String(describing: HeadlineCell.self)
    
    // MARK: Views
    let imageView = UIImageView()
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17)
        return view
    }()
    let publishInfoLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.numberOfLines = 2
        return view
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(publishInfoLabel)
        
        imageView.snp.makeConstraints { make in
            make.size
                .equalTo(150)
            make.leading.verticalEdges
                .equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading
                .equalTo(imageView.snp.trailing)
            make.trailing.top
                .equalToSuperview()
        }
        
        publishInfoLabel.snp.makeConstraints { make in
            make.leading
                .equalTo(imageView.snp.trailing)
            make.trailing.top
                .equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
