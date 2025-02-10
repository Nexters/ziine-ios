//
//  ArtworkInteractor.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ArtworkFeatureInterface
import DesignSystem
import ListKit

protocol ArtworkViewPresentable: AnyObject {
    var listener: ArtworkViewPresentableListener? { get set }
    
    func reloadCollectionUI(artworkModels: [ArtworkModel])
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
    
    func circleButtonTapped(action: CircleButtonListener) {
        switch action {
        case .buttonTapped:
            listener?.addButtonTapped()
        @unknown default:
            break
        }
    }
    
    
    func uploadButtonTapped() {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 페이지네이션 현재 없음
    }
    
    private func fetch() {
        Task { @MainActor in
            let result = await dependency.fetchArtworkListUseCase.fetch()
            switch result {
            case .success(let success):
                presenter?.reloadCollectionUI(artworkModels: success)
            case .failure(let failure):
                // !!!: - 토스트 팝업
                
                presenter?.reloadCollectionUI(artworkModels: [])
                break
            }
        }
    }
    
}
