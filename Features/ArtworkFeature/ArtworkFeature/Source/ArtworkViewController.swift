//
//  ArtworkViewController.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ArtworkFeatureInterface

class UploadViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

// MARK: - Builder





public final class ArtworkViewBuilder: ArtworkViewBuildable {
    let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        // TODO: - replace dependency
    }
    
    public func build(with listener: ArtworkListener?) -> ArtworkRouting {
        let viewController = ArtworkViewController()
        
        let interactor = ArtworkInteractor()
        
        let router = ArtworkRouter(
            navigationController: navigationController,
            viewController: viewController
        )
        
        interactor.presenter = viewController
        interactor.listener = listener
        interactor.router = router
        
        return router
    }
}

// MARK: - Router

final class ArtworkRouter: ArtworkRouting {
    
    let navigationController: UINavigationController
    var viewController: UIViewController?
    
    init(
        navigationController: UINavigationController,
        viewController: UIViewController?
    ) {
        self.navigationController = navigationController
        self.viewController = viewController
    }
    
    // MARK: - Upload
    
    func pushToUpload() {
        print(#function)
        
        let viewController = UploadViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - Interactor

protocol ArtworkInteractorable: AnyObject {
    var router: ArtworkRouting? { get set }
    var listener: ArtworkListener? { get set }
}

final class ArtworkInteractor: ArtworkInteractorable,
                               ArtworkViewPresentableListener
{
    weak var router: ArtworkRouting?
    weak var listener: ArtworkListener?
    weak var presenter: ArtworkViewPresentable?
    
    init() {}
    
    func fetch() { }
    
    func itemSelected(indexPath: IndexPath) {
        print(#file, #function)
        
        router?.pushToUpload()
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
        
        listener?.itemSelected(indexPath: .init(row: 0, section: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
//    private let collectionView = UICollectionView()
    
    private func configureUI() {
        // TODO: - 스냅킷 도입 예정
        
        view.backgroundColor = .red
    }
    
    // TODO: - 컬렉션 UI 도입해서 분리할 예정
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        listener?.itemSelected(indexPath: indexPath)
//    }
}
