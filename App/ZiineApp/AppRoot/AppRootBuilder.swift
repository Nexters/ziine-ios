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
        let interactor = AppRootInteractor()
        
        let artworkBuilder = ArtworkViewBuilder()
        
        let router = AppRootRouter(
            interactor: interactor,
            artworkBuildable: artworkBuilder
        )
        
        return router
    }
}


protocol AppRootInteractable: ArtworkListener { }

final class AppRootInteractor: AppRootInteractable {}

protocol AppRootRouting {
    func configureTabs() -> [UIViewController]
}

final class AppRootRouter: AppRootRouting {
    
    var interactor: AppRootInteractable?
    
    private let artworkBuildable: ArtworkViewBuildable
    private var artworkRouting: ArtworkRouting?
    
    init(
        interactor :AppRootInteractable,
        artworkBuildable: ArtworkViewBuildable
    ) {
        self.interactor = interactor
        
        self.artworkBuildable = artworkBuildable
    }
    
    func configureTabs() -> [UIViewController] {
        let artworkRouting = artworkBuildable.build(with: interactor)
        self.artworkRouting = artworkRouting
        
        let viewControllers = [
            artworkRouting.viewController
        ]
        
        return viewControllers
    }
}

protocol AppRootTabBarControllable {
    func build() -> UITabBarController
    func setViewControllers(_ viewControllers: [UIViewController])
}

final class AppRootTabBarController: UITabBarController, AppRootTabBarControllable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    
    func setViewControllers(_ viewControllers: [UIViewController]) {
        super.setViewControllers(viewControllers, animated: false)
    }
    
    func build() -> UITabBarController {
        return self
    }
}
