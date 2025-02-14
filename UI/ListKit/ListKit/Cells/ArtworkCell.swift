//
//  ArtworkCell.swift
//  ListKit
//
//  Created by Geon Woo lee on 2/8/25.
//

import UIKit
import DesignSystem
internal import SnapKit
internal import Kingfisher

public final class ArtworkCell: UICollectionViewCell {
    
    public static let id = String(describing: ArtworkCell.self)
    
    public func configure(_ dataModel: ListDataModel) {
        thumbnailImageView.kf.setImage(
            with: URL(string: dataModel.thumbnailImageUrlString ?? "")
        )
        
        profileImageView.kf.setImage(
            with: URL(string: dataModel.profileImageUrlString ?? "")
        )
        
        userNameLabel.text = dataModel.username
        artworkTitleLabel.text = dataModel.title
    }
    
    // MARK: - Initialize
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = nil
        profileImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 28, height: 28))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gradientImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = ZiineImage.uiImage(.dimm)
        return iv
    }()
    
    private let userNameLabel: UILabel = {
        let lb = UILabel()
        lb.font = ZiineFont.p2
        lb.textColor = ZiineColor.uiColor(.g0)
        return lb
    }()
    
    private let artworkTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = ZiineFont.h4
        lb.textColor = ZiineColor.uiColor(.g0)
        lb.numberOfLines = 1
        return lb
    }()
    
    private func configureUI() {
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        thumbnailImageView.addSubview(gradientImageView)
        gradientImageView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(thumbnailImageView.snp.height).dividedBy(3)
        }
        
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalTo(20)
            $0.width.height.equalTo(profileImageView.frame.height)
        }
        
        contentView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView.snp.centerY)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(6)
        }
        
        
        
        contentView.addSubview(artworkTitleLabel)
        artworkTitleLabel.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview().inset(20)
        }
    }
}
