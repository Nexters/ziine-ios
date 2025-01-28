//
//  ArtworkViewBuilder.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ArtworkFeatureInterface

public final class ArtworkViewBuilder: ArtworkViewBuildable {
    let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        // TODO: - replace dependency
    }
    
    public func build(with listener: ArtworkListener?) -> ArtworkRouting {
        let viewController = ArtworkViewController()
        let interactor = ArtworkInteractor()
        
        let router = ArtworkRouter(
            navigationController: navigationController,
            viewController: viewController
        )
        
        interactor.presenter = viewController
        interactor.listener = listener
        interactor.router = router
        
        return router
    }
}
