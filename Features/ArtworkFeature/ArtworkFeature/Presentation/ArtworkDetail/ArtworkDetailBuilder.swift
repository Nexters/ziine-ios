//
//  ArtworkDetailBuilder.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/11/25.
//

import UIKit
import ArtworkFeatureInterface

public final class ArtworkDetailBuilder: ArtworkDetailViewBuildable {
    public func build(with listener: ArtworkDetailListener?) -> ArtworkDetailRouting {
        let viewController = ArtworkDetailViewController()
        
        let interactor = ArtworkDetailInteractor()
        let router = ArtworkDetailRouter(viewController: viewController)
        
        viewController.listener = interactor
        interactor.listener = listener
        interactor.router = router
        interactor.presenter = viewController
        
        return router
    }
}
