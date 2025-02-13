//
//  ArtworkInteractor.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ListKit
import CommonUI
import DesignSystem
import ArtworkFeatureInterface

protocol ArtworkViewPresentable: AnyObject {
    var listener: ArtworkViewPresentableListener? { get set }
    
    func reloadCollectionUI(artworkModels: [ArtworkModel])
    func showsNetworkErrorUI()
}

protocol ArtworkInteractorable: AnyObject {
    var router: ArtworkRouting? { get set }
    var listener: ArtworkListener? { get set }
}

protocol ArtworkInteractorDependency: AnyObject {
    var fetchArtworkListUseCase: FetchArtworkListUseCase { get }
}

final class ArtworkInteractor:
    ArtworkInteractorable,
    ArtworkViewPresentableListener
{
    var router: ArtworkRouting?
    var listener: ArtworkListener?
    var presenter: ArtworkViewPresentable?
    
    var dependency: ArtworkInteractorDependency
    
    init(dependency: ArtworkInteractorDependency) {
        self.dependency = dependency
    }
    
    func didBecomeActive() {
        self.fetch()
    }
    
    func modelSelected(dataModel: ListDataModel) {
        self.listener?.artworkDetail(dataModel: dataModel)
    }
    
    func circleButtonListener(action: DesignSystem.CircleButtonListener) {
        switch action {
        case .buttonTapped:
            listener?.addButtonTapped()
        @unknown default:
            break
        }
    }
    
    func networoErrorListener(action: CommonUI.NetworkErrorUIListener) {
        switch action {
        case .retryButtonTapped:
            self.fetch()
        @unknown default:
            break
        }
    }
    
    private func fetch() {
        Task { @MainActor in
            let result = await dependency.fetchArtworkListUseCase.fetch()
            switch result {
            case .success(let success):
                presenter?.reloadCollectionUI(artworkModels: success)
            case .failure:
                presenter?.showsNetworkErrorUI()
            }
        }
    }
    
}
