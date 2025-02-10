//
//  ArtworkDetailBuilder.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/11/25.
//

import UIKit
import ArtworkFeatureInterface

public final class ArtworkDetailBuilder: ArtworkDetailViewBuildable {
    
    public init() { }
    
    public func build(
        urlString: String,
        with listener: ArtworkDetailListener?
    ) -> ArtworkDetailRouting {
        let viewController = ArtworkDetailViewController()
        
        let interactor = ArtworkDetailInteractor(urlString: urlString)
        let router = ArtworkDetailRouter(viewController: viewController)
        
        viewController.listener = interactor
        interactor.listener = listener
        interactor.router = router
        interactor.presenter = viewController
        
        interactor.didBecomeActive()
        
        return router
    }
}
