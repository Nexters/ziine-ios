//
//  PostingViewController.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import SwiftUI
import ThirdParty
import DesignSystem
internal import SnapKit
import PostingFeatureInterface

protocol PostingViewPresentableListener: AnyObject {
    func postingGuideView(listener: PostingGuideViewListener)
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
    
    private lazy var postingGuideView: UIView = {
        let swiftUIView = PostingGuideView { [weak self] action in
            self?.listener?.postingGuideView(listener: action)
        }
        let hostingController = UIHostingController(
            rootView: swiftUIView
        )
        hostingController.view.backgroundColor = .clear
        return hostingController.view
    }()
    
    private func configureUI() {
        view.backgroundColor = ZiineColor.uiColor(.g900)
        
        view.addSubview(postingGuideView)
        postingGuideView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
