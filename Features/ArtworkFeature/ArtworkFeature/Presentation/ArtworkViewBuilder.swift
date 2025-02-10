//
//  ArtworkViewBuilder.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ArtworkFeatureInterface
import PostingFeatureInterface

public final class ArtworkViewBuilder: ArtworkViewBuildable {
    
    public init() {}
    
    public func build(with listener: ArtworkListener?) -> ArtworkRouting {
        let component = ArtworkInteractorComponent()
        let viewController = ArtworkViewController()
        
        let interactor = ArtworkInteractor(
            dependency: component
        )
        
        let router = ArtworkRouter(
            viewController: viewController
        )
        
        viewController.listener = interactor
        interactor.listener = listener
        interactor.router = router
        interactor.presenter = viewController
        
        interactor.didBecomeActive()
        
        return router
    }
}

final class ArtworkInteractorComponent: ArtworkInteractorDependency {
    var fetchArtworkListUseCase: any FetchArtworkListUseCase
    
    init() {
        // TODO: - 의존성 주입
        self.fetchArtworkListUseCase = DefaultFetchArtworkListUseCase(
            artworkRepository: DefaultArtworkRepository()
        )
    }
}
