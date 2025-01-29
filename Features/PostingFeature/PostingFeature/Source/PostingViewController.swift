//
//  PostingViewController.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ThirdParty
internal import SnapKit
import PostingFeatureInterface

protocol PostingViewPresentableListener: AnyObject {
    func uploadButtonTapped()
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
    
    private func configureUI() {
        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
    }
}
