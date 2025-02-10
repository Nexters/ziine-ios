//
//  ArtworkDetailBuilder.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/11/25.
//

import UIKit
import ArtworkFeatureInterface

public final class ArtworkDetailBuilder: ArtworkDetailViewBuildable {
    
    /// 웹뷰 요청할 url
    private var urlString: String
    
    public init(urlString: String) {
        self.urlString = urlString
    }
    
    public func build(with listener: ArtworkDetailListener?) -> ArtworkDetailRouting {
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
