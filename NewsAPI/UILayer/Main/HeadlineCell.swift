//
//  HeadlineCell.swift
//  NewsAPI
//
//  Created by 구홍석 on 7/31/24.
//

import Kingfisher
import SnapKit
import UIKit

final class HeadlineCell: UICollectionViewCell {
    // MARK: Constants
    static let identifier = String(describing: HeadlineCell.self)
    
    // MARK: Properties
    private var isDarkMode: Bool {
        traitCollection.userInterfaceStyle == .dark
    }
    
    // MARK: Views
    let placeholderImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "photo")
        return view
    }()
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 0.3
        return view
    }()
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.numberOfLines = 3
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
        layout()
        updateColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateColors()
    }
}

// MARK: - Functions
extension HeadlineCell {
    private func layout() {
        contentView.addSubview(placeholderImageView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(publishInfoLabel)
        
        imageView.snp.makeConstraints { make in
            make.size
                .equalTo(110)
            make.leading
                .equalToSuperview()
                .offset(10)
            make.top
                .equalToSuperview()
                .offset(10)
        }
        
        placeholderImageView.snp.makeConstraints { make in
            make.size
                .equalTo(50)
            make.center
                .equalTo(imageView.snp.center)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading
                .equalTo(imageView.snp.trailing)
                .offset(10)
            make.trailing
                .equalToSuperview()
                .offset(-8)
            make.top
                .equalToSuperview()
                .offset(16)
        }
        
        publishInfoLabel.snp.makeConstraints { make in
            make.leading
                .equalTo(imageView.snp.trailing)
                .offset(8)
            make.trailing
                .equalToSuperview()
                .offset(-8)
            make.bottom
                .equalToSuperview()
                .offset(-16)
        }
    }
    
    private func updateColors() {
        let isDarkMode = self.isDarkMode
        placeholderImageView.image = placeholderImageView.image?.withTintColor(
            isDarkMode ? .darkGray : .lightGray,
            renderingMode: .alwaysOriginal
        )
        imageView.layer.borderColor = isDarkMode ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor
        publishInfoLabel.textColor = isDarkMode ? .lightGray : .darkGray
    }
    
    func setup(data: HeadlineCellData) {
        KF.url(URL(string: data.urlToImage))
            .placeholder(nil)
            .loadDiskFileSynchronously()
            .fade(duration: 0.25)
            .set(to: imageView)
        titleLabel.text = data.title
        titleLabel.textColor = data.articleVisited ? .red : .label
        publishInfoLabel.text = "\(data.formattedPublishedAt) by \(data.author)"
    }
}
