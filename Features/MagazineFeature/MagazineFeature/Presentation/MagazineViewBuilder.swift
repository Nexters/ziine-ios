//
//  MagazineViewBuilder.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/7/25.
//

import UIKit
import MagazineFeatureInterface

public final class MagazineViewBuilder: MagazineViewBuildable {
    
    public init() {}
    
    public func build(with listener: MagazineListener?) -> MagazineRouting {
        let component = MagazineInteractorComponent()
        let viewController = MagazineViewController()
        
        let interactor = MagazineInteractor(dependency: component)
        let router = MagazineRouter(viewController: viewController)
        
        viewController.listener = interactor
        interactor.listener = listener
        interactor.router = router
        interactor.presenter = viewController
        
        return router
    }
}

final class MagazineInteractorComponent: MagazineInteractorDependency {
    var fetchMagazineListUseCase: any FetchMagazineListUseCase
        
    init() {
        // TODO: - 의존성 주입
        self.fetchMagazineListUseCase = DefaultFetchMagazineListUseCase(
            magazineRepository: DefaultMagazineRepository()
        )
    }
}
