//
//  MagazineInteractor.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/7/25.
//

import UIKit
import CommonUI
import DesignSystem
import MagazineFeatureInterface

protocol MagazineViewPresentable: AnyObject {
    var listener: MagazineViewPresentableListener? { get set }
    func reloadMagazineCarousel(magazineModels: [MagazineModel])
    func showsNetworkErrorUI()
}

protocol MagazineInteractorable: AnyObject {
    var router: MagazineRouting? { get set }
    var listener: MagazineListener? { get set }
}

protocol MagazineInteractorDependency: AnyObject {
    var fetchMagazineListUseCase: FetchMagazineListUseCase { get }
}

final class MagazineInteractor:
    MagazineInteractorable,
    MagazineViewPresentableListener
{
    var router: MagazineRouting?
    var listener: MagazineListener?
    var presenter: MagazineViewPresentable?
    
    var dependency: MagazineInteractorDependency
    
    init(dependency: MagazineInteractorDependency) {
        self.dependency = dependency
    }
    
    func didBecomeActive() {
        self.fetch()
    }
    
    func itemSelected(model: MagazineModel) {
        router?.pushToDetailView()
    }
    
    func networkError(action: CommonUI.NetworkErrorUIListener) {
        switch action {
        case .retryButtonTapped:
            self.fetch()
        @unknown default:
            break
        }
    }
    
    func fetch() {
        Task { @MainActor in
            let result = await dependency.fetchMagazineListUseCase.fetch()
            switch result {
            case .success(let data):
                presenter?.reloadMagazineCarousel(magazineModels: data)
            case .failure(let failure):
                presenter?.showsNetworkErrorUI()
                break
            }
        }
    }
}
