//
//  AppRootBuildable.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 1/29/25.
//

import UIKit
import ArtworkFeature
import ArtworkFeatureInterface

protocol AppRootBuildable {
    func build() -> AppRootRouting
}

final class AppRootBuilder: AppRootBuildable {
    
    func build() -> AppRootRouting {
        let artworkBuilder = ArtworkViewBuilder()
        let router = AppRootRouter(artworkBuildable: artworkBuilder)
        
        return router
    }
}


final class AppRootInteractor {}

protocol AppRootRouting {
    func configureTabs() -> [UIViewController]
}

final class AppRootRouter: AppRootRouting {
    
    private let artworkBuildable: ArtworkViewBuildable
    private var artworkRouting: ArtworkRouting?
    
    init(artworkBuildable: ArtworkViewBuildable) {
        self.artworkBuildable = artworkBuildable
    }
    
    func configureTabs() -> [UIViewController] {
        let artworkRouting = artworkBuildable.build(with: nil)
        
        self.artworkRouting = artworkRouting
        
        let viewControllers = [
            artworkRouting.viewController
        ]
        
        return viewControllers
    }
}

final class AppRootTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    
    func setViewControllers(_ viewControllers: [UIViewController]) {
        super.setViewControllers(viewControllers, animated: false)
    }
}
