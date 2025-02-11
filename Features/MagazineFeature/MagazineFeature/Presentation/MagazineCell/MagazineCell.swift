//
//  MagazineCell.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/7/25.
//

import UIKit
import SwiftUI
import DesignSystem
import MagazineFeatureInterface

import ThirdParty
internal import SnapKit

final class MagazineCell: UICollectionViewCell {
    static let identifier = "MagazineCell"
    
    // MARK: UI Components
    private var magazineTypeLogoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        // for test
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        
        label.setTextWithLineHeight(text: "매거진 제목 매거진 ", fontStyle: .h3)
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        
        label.setTextWithLineHeight(text: "요약된 내용 요약된 내용", fontStyle: .p2)
        
        return label
    }()
    
    private lazy var keywordCapsuleView: UIView = {
        let hostingController = UIHostingController(
            rootView: KeywordCapsuleView(
                keywords: ["키워드1", "키워드2", "키워드3"]
            )
        )
        hostingController.view.backgroundColor = .clear
        return hostingController.view
    }()
    
    private var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        
        // for test
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func configureUI() {
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = ZiineColor.uiColor(.p200)
        
        contentView.addSubview(magazineTypeLogoImageView)
        magazineTypeLogoImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(28)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(magazineTypeLogoImageView.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(keywordCapsuleView)
        keywordCapsuleView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).inset(-24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(thumbnailImageView.snp.width)
        }
    }
    
    func configure(with model: MagazineModel) {
        // TODO: Configure with MagazineModel
    }
}
