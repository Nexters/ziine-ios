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
import MagazineFeature
import MagazineFeatureInterface

protocol AppRootBuildable {
    func build() -> AppRootRouting
}

final class AppRootBuilder: AppRootBuildable {
    
    func build() -> AppRootRouting {
        let interactor = AppRootInteractor()
        
        let viewController = AppRootViewController()
        
        let artworkBuilder = ArtworkViewBuilder()
        let postingBuilder = PostingViewBuilder()
        let magazineBuilder = MagazineViewBuilder()
        
        let router = AppRootRouter(
            viewController: viewController,
            interactor: interactor,
            artworkBuildable: artworkBuilder,
            postingBuildable: postingBuilder,
            magazineBuildable: magazineBuilder
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
