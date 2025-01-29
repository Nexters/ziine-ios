//
//  PostingViewController.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import PostingFeatureInterface

protocol PostingViewPresentableListener: AnyObject {
    func itemSelected(indexPath: IndexPath)
}

final class PostingViewController: UIViewController,
                                   PostingViewPresentable,
                                   UICollectionViewDelegate
{
    var listener: PostingViewPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
//    private let collectionView = UICollectionView()
    
    private func configureUI() {
        // TODO: - 스냅킷 도입 예정
        
        view.backgroundColor = .green
        
        let btn = UIButton()
        btn.setTitle("Posting Detail", for: .normal)
        btn.addTarget(self, action: #selector(onTapGoToDetail), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btn)
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
    
    @objc func onTapGoToDetail() {
        print("🍋",listener, self)
        listener?.itemSelected(indexPath: .init(item: 0, section: 0))
    }
    
    // TODO: - 컬렉션 UI 도입해서 분리할 예정
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        listener?.itemSelected(indexPath: indexPath)
//    }
}
