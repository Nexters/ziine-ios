//
//  ArtworkViewBuilder.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ArtworkFeatureInterface

public final class ArtworkViewBuilder: ArtworkViewBuildable {
    
    public init() {}
    
    public func build(with listener: ArtworkListener?) -> ArtworkRouting {
        let viewController = ArtworkViewController()
        let interactor = ArtworkInteractor()
        
        let router = ArtworkRouter(
            viewController: viewController
        )
        
        print(viewController.listener, interactor)
        
        viewController.listener = interactor
        
        print(viewController.listener, interactor)
        print("🥕",viewController)
        interactor.listener = listener
        interactor.router = router
        
        return router
    }
}
