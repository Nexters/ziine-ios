//
//  AppRootRouting.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 2/2/25.
//

import UIKit
import ArtworkFeatureInterface
import PostingFeatureInterface
import MagazineFeatureInterface

protocol AppRootRouting {
    var viewController: UIViewController { get }
    
    func configurePages() -> [ZiinStatusTabBarItem: UIViewController]
    func pushToPosting()
    func pushToArtworkDetail(urlString: String)
}

final class AppRootRouter: AppRootRouting {
    var viewController: UIViewController
    
    var interactor: AppRootInteractable?
    
    private let artworkBuildable: ArtworkViewBuildable
    private var artworkRouting: ArtworkRouting?
    
    private let postingBuildable: PostingViewBuildable
    private var postingRouting: PostingRouting?
    
    private let artworkDetailViewBuildable: ArtworkDetailViewBuildable
    private var ArtworkDetailRouting: ArtworkDetailRouting?
    
    private let magazineBuildable: MagazineViewBuildable
    private var magazineRouting: MagazineRouting?
    
    init(
        viewController: UIViewController,
        interactor: AppRootInteractable,
        artworkBuildable: ArtworkViewBuildable,
        artworkDetailViewBuildable: ArtworkDetailViewBuildable
        postingBuildable: PostingViewBuildable,
        magazineBuildable: MagazineViewBuildable
    ) {
        self.viewController = viewController
        self.interactor = interactor
        
        self.artworkBuildable = artworkBuildable
        self.postingBuildable = postingBuildable
        self.artworkDetailViewBuildable = artworkDetailViewBuildable
        self.magazineBuildable = magazineBuildable
    }
    
    func configurePages() -> [ZiinStatusTabBarItem: UIViewController] {
        let artworkRouting = artworkBuildable.build(with: interactor)
        self.artworkRouting = artworkRouting
        
        let postingRouting = postingBuildable.build(with: interactor)
        self.postingRouting = postingRouting
        
        let magazineRouting = magazineBuildable.build(with: interactor)
        self.magazineRouting = magazineRouting
        
        return [
            .artworks: artworkRouting.viewController,
            .magazine: magazineRouting.viewController,
        ]
    }
    
    func pushToPosting() {
        let routing = postingBuildable.build(with: nil)
        let uiViewController = routing.viewController
        
        viewController.navigationController?.pushViewController(uiViewController, animated: true)
    }
    
    func pushToArtworkDetail(urlString: String) {
        
        // TODO: - 우리 웹 로직으로 변경
        let routing = artworkDetailViewBuildable.build(
            urlString: urlString,
            with: nil
        )
        let uiViewController = routing.viewController
        
        viewController.navigationController?.pushViewController(uiViewController, animated: true)
    }
}
