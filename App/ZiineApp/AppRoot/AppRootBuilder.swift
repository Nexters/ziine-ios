//
//  AppRootBuildable.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 1/29/25.
//

import UIKit
import SwiftUI
import SnapKit
import ArtworkFeature
import ArtworkFeatureInterface
import PostingFeature
import PostingFeatureInterface

protocol AppRootBuildable {
    func build() -> AppRootRouting
}

final class AppRootBuilder: AppRootBuildable {
    
    func build() -> AppRootRouting {
        let interactor = AppRootInteractor()
        
        let viewController = AppRootViewController()
        
        let postingBuilder = PostingViewBuilder()
        let artworkBuilder = ArtworkViewBuilder()
        
        let router = AppRootRouter(
            viewController: viewController,
            interactor: interactor,
            artworkBuildable: artworkBuilder,
            postingBuildable: postingBuilder
        )
        
        viewController.listener = interactor
        interactor.presenter = viewController
        interactor.router = router
        
        let pages = router.configurePages()
        interactor.configure(pages)
        if let page = pages[.artworks] {
            viewController.set(page: page)
        }
        
        return router
    }
}
