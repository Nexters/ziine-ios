//
//  AppRootBuildable.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 1/29/25.
//

import UIKit
import SwiftUI
import SnapKit
import ArtworkFeature
import ArtworkFeatureInterface
import PostingFeature
import PostingFeatureInterface


protocol AppRootBuildable {
    func build() -> AppRootRouting
}

final class AppRootBuilder: AppRootBuildable {
    
    func build() -> AppRootRouting {
        let interactor = AppRootInteractor()
        
        let viewController = AppRootContainerViewController()
        
        let artworkBuilder = ArtworkViewBuilder()
        let postingBuilder = PostingViewBuilder()
        
        let router = AppRootRouter(
            viewController: viewController,
            interactor: interactor,
            artworkBuildable: artworkBuilder,
            postingBuildable: postingBuilder
        )
        
        let pages = router.configurePages()
        interactor.configure(pages)
        if let page = pages[.artworks] {
            viewController.set(page: page)
        }
        
        return router
    }
}


protocol AppRootInteractable: ArtworkListener, PostingListener {
    func onChange(statusBarItem: ZiinStatusTabBarItem)
}

final class AppRootInteractor: AppRootInteractable {
    var router: AppRootRouting?
    var presenter: AppRootContainerViewPresentable?
    
    /// 페이지 정보
    private var pageDictionary: [ZiinStatusTabBarItem: UIViewController] = [:]
    
    func configure(_ pageDictionary: [ZiinStatusTabBarItem: UIViewController]) {
        self.pageDictionary = pageDictionary
    }
    
    func onChange(statusBarItem: ZiinStatusTabBarItem) {
        switch statusBarItem {
        case .artworks:
            if let page = pageDictionary[.artworks] {
                presenter?.set(page: page)
            }
        case .magazine:
            if let page = pageDictionary[.magazine] {
                presenter?.set(page: page)
            }
        }
    }
    
}

protocol AppRootRouting {
    var viewController: UIViewController { get }
    
    func configurePages() -> [ZiinStatusTabBarItem: UIViewController]
}

final class AppRootRouter: AppRootRouting {
    var viewController: UIViewController
    
    var interactor: AppRootInteractable?
    
    private let artworkBuildable: ArtworkViewBuildable
    private var artworkRouting: ArtworkRouting?
    
    private let postingBuildable: PostingViewBuildable
    private var postingRouting: PostingRouting?
    
    init(
        viewController: UIViewController,
        interactor :AppRootInteractable,
        artworkBuildable: ArtworkViewBuildable,
        postingBuildable: PostingViewBuildable
    ) {
        self.viewController = viewController
        self.interactor = interactor
        
        self.artworkBuildable = artworkBuildable
        self.postingBuildable = postingBuildable
    }
    
    func configurePages() -> [ZiinStatusTabBarItem: UIViewController] {
        let artworkRouting = artworkBuildable.build(with: interactor)
        self.artworkRouting = artworkRouting
        
        let postingRouting = postingBuildable.build(with: interactor)
        self.postingRouting = postingRouting
        
        let a = artworkRouting.viewController
        a.view.backgroundColor = .red
        
        return [
            .artworks: a,
            .magazine: postingRouting.viewController
        ]
    }
}

// MARK: - PageViewController


protocol AppRootContainerViewPresentable {
    func set(page: UIViewController)
}

protocol AppRootContainerViewPresentableListener {
    func onChange(statusBarItem: ZiinStatusTabBarItem)
}

final class AppRootContainerViewController: UIViewController,
                                            AppRootContainerViewPresentable
{
    var listener: AppRootContainerViewPresentableListener?
    
    // MARK: - Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
    private lazy var statusBar: UIView = {
        let statusBar = ZiineStatusBar { [weak self] action in
            switch action {
            case let .onChange(statusBarItem):
                self?.listener?.onChange(statusBarItem: statusBarItem)
            }
        }
        
        let hostingController = UIHostingController(rootView: statusBar)
        return hostingController.view!
    }()
    
    private lazy var pageViewController: AppRootPageViewController = {
        let pageViewController = AppRootPageViewController()
        pageViewController.didMove(toParent: self)
        return pageViewController
    }()
    
    private func configureUI() {
        view.addSubview(statusBar)
        statusBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(65)
        }
        
        let pagerView = pageViewController.view!
        view.addSubview(pagerView)
        pagerView.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func set(page: UIViewController) {
        pageViewController.setViewController(page: page)
    }
}

protocol AppRootPageViewControllable {
    func setViewController(page: UIViewController)
}

final class AppRootPageViewController: UIPageViewController, AppRootPageViewControllable {
    
    // MARK: - Initialize
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// `setViewController` 설정
    func setViewController(page: UIViewController) {
        setViewControllers([page], direction: .forward, animated: false, completion: nil)
    }
}
