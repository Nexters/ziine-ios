//
//  MagazineInteractor.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/7/25.
//

import UIKit
import DesignSystem
import MagazineFeatureInterface

protocol MagazineViewPresentable: AnyObject {
    var listener: MagazineViewPresentableListener? { get set }
    func reloadMagazineCarousel(magazineModels: [MagazineModel])
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
    
    func fetch() {
        Task { @MainActor in
            let result = await dependency.fetchMagazineListUseCase.fetch()
            switch result {
            case .success(let data):
                presenter?.reloadMagazineCarousel(magazineModels: data)
            case .failure(let failure):
                print("failed to fetch magazine list: \(failure)")
                break
            }
        }
    }
    
    func itemSelected(indexPath: IndexPath) {
        router?.pushToDetailView()
    }
}
