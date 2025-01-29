//
//  PostingViewBuilder.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import PostingFeatureInterface

public final class PostingViewBuilder: PostingViewBuildable {
    
    public init() {}
    
    public func build(with listener: PostingListener?) -> PostingRouting {
        let viewController = PostingViewController()
        let interactor = PostingInteractor()
        let router = PostingRouter(viewController: viewController)
        
        viewController.listener = interactor
        interactor.listener = listener
        interactor.router = router
        
        return router
    }
}
