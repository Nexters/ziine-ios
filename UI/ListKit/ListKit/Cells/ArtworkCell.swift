//
//  ArtworkCell.swift
//  ListKit
//
//  Created by Geon Woo lee on 2/8/25.
//

import UIKit
internal import SnapKit

public final class ArtworkCell: UICollectionViewCell {
    
    public static let id = String(describing: ArtworkCell.self)
    
    func configure(_ dataModel: ListDataModel) {
        dataModel
    }
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 28, height: 28))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.height
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    private let artworkTitleLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    private func configureUI() {
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
            $0.leading.bottom.trailing.equalTo(20)
        }
    }
}
