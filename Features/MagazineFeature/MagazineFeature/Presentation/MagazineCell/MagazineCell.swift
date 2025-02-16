//
//  MagazineCell.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/7/25.
//

import UIKit
import Utils
import SwiftUI
import ThirdParty
import DesignSystem
import MagazineFeatureInterface

internal import SnapKit
internal import Kingfisher

final class MagazineCell: UICollectionViewCell {
    public static let identifier = String(describing: MagazineCell.self)
    
    func configure(with model: MagazineModel) {
        titleLabel.setTextWithLineHeight(text: model.title, fontStyle: .h3)
        descriptionLabel.setTextWithLineHeight(text: model.summary, fontStyle: .p2)
        keywordCapsuleView.rootView.keywords = model.keywords
        thumbnailImageView.kf.setImage(
            with: URL(string: model.thumbnailImageURL)
        )
        
        contentView.backgroundColor = UIColor(hex: model.backgroundColor)
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    private func configureUI() {
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(keywordCapsuleView.view)
        keywordCapsuleView.view.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).inset(-24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(thumbnailImageView.snp.width)
        }
    }
    
    // MARK: UI Components
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        
        label.setTextWithLineHeight(text: "요약된 내용 요약된 내용", fontStyle: .p2)
        
        return label
    }()
    
    private lazy var keywordCapsuleView: UIHostingController<KeywordCapsuleView> = {
        let hostingController = UIHostingController(
            rootView: KeywordCapsuleView(keywords: [])
        )
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        
        // for test
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
}
