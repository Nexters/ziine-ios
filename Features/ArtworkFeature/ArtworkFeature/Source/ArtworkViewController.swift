//
//  ArtworkViewController.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit

// MARK: - Builder

final class ArtworkViewBuilder { }

// MARK: - Router

protocol ArtworkRouting: AnyObject {
    
}

final class ArtworRouter: ArtworkRouting {
    var navigationContoller: UINavigationController?
    
    init(navigationContoller: UINavigationController) {
        self.navigationContoller = navigationContoller
    }
}

// MARK: - Interactor

protocol ArtworkInteractorOutput: AnyObject { }

protocol ArtworkInteractorable: AnyObject {
    var router: ArtworkRouting? { get set }
    
    // !!!: - add to listener
}

final class ArtworkInteractor: ArtworkInteractorable,
                               ArtworkViewPresentableListener
{
    weak var router: ArtworkRouting?
    weak var listener: ArtworkViewPresentableListener?
    
    weak var presenter: ArtworkViewPresentable?
    
    init(presenter: ArtworkViewPresentable) {
        self.presenter = presenter
        
        presenter.listener = self
    }
    
    func fetch() { }
    
    func itemSelected(indexPath: IndexPath) {
        print(#file, #function)
    }
    
}

// MARK: - Presneter

protocol ArtworkViewPresentable: AnyObject {
    var listener: ArtworkViewPresentableListener? { get set }
}

protocol ArtworkViewPresentableListener: AnyObject {
    func itemSelected(indexPath: IndexPath)
}

final class ArtworkViewController: UIViewController,
                                   ArtworkViewPresentable,
                                   UICollectionViewDelegate
{
    weak var listener: ArtworkViewPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
    private let collectionView = UICollectionView()
    
    private func configureUI() {
        // TODO: - 스냅킷 도입 예정
    }
    
    // TODO: - 컬렉션 UI 도입해서 분리할 예정
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listener?.itemSelected(indexPath: indexPath)
    }
}
