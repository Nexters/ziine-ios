//
//  MagazineDetailBuilder.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/14/25.
//

import UIKit
import MagazineFeatureInterface

public final class MagazineDetailBuilder: MagazineDetailViewBuildable {
    
    public init() { }
    
    public func build(
        urlString: String,
        with listener: MagazineDetailListener?
    ) -> MagazineDetailRouting {
        let viewController = MagazineDetailViewController()
        let interactor = MagazineDetailInteractor(urlString: urlString)
        let router = MagazineDetailRouter(viewController: viewController)

        viewController.listener = interactor
        interactor.listener = listener
        interactor.router = router
        interactor.presenter = viewController

        return router
    }
}
