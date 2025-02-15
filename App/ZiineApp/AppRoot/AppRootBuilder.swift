//
//  AppRootBuildable.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 1/29/25.
//

import UIKit
import SwiftUI
internal import SnapKit
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
        
        let postingBuilder = PostingViewBuilder()
        let artworkBuilder = ArtworkViewBuilder()
        let artworkDetailBuilder = ArtworkDetailBuilder()
        let magazineBuilder = MagazineViewBuilder()
        let magazineDetailBuilder = MagazineDetailBuilder()
        
        let router = AppRootRouter(
            viewController: viewController,
            interactor: interactor,
            artworkBuildable: artworkBuilder,
            artworkDetailViewBuildable: artworkDetailBuilder,
            postingBuildable: postingBuilder,
            magazineBuildable: magazineBuilder,
            magazineDetailViewBuildable: magazineDetailBuilder
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
