//
//  AppRootRouting.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 2/2/25.
//

import UIKit
import ArtworkFeatureInterface
import PostingFeatureInterface

protocol AppRootRouting {
    var viewController: UIViewController { get }
    
    func configurePages() -> [ZiinStatusTabBarItem: UIViewController]
    func pushToArtworkDetail()
}

final class AppRootRouter: AppRootRouting {
    var viewController: UIViewController
    
    var interactor: AppRootInteractable?
    
    private let artworkBuildable: ArtworkViewBuildable
    private var artworkRouting: ArtworkRouting?
    
    private let postingBuildable: PostingViewBuildable
    private var postingRouting: PostingRouting?
    
    init(
        viewController: UIViewController,
        interactor: AppRootInteractable,
        artworkBuildable: ArtworkViewBuildable,
        postingBuildable: PostingViewBuildable
    ) {
        self.viewController = viewController
        self.interactor = interactor
        
        self.artworkBuildable = artworkBuildable
        self.postingBuildable = postingBuildable
    }
    
    func configurePages() -> [ZiinStatusTabBarItem: UIViewController] {
        let artworkRouting = artworkBuildable.build(with: interactor)
        self.artworkRouting = artworkRouting
        
        let postingRouting = postingBuildable.build(with: interactor)
        self.postingRouting = postingRouting
        
        return [
            .artworks: artworkRouting.viewController,
            .magazine: postingRouting.viewController
        ]
    }
    
    func pushToArtworkDetail() {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
//        navigationController.pushViewController(viewController, animated: true)
//        viewController.present(vc, animated: true)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
