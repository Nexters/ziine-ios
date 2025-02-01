//
//  AppRootBuildable.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 1/29/25.
//

import UIKit
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
        
        let artworkBuilder = ArtworkViewBuilder()
        let postingBuilder = PostingViewBuilder()
        
        let router = AppRootRouter(
            interactor: interactor,
            artworkBuildable: artworkBuilder,
            postingBuildable: postingBuilder
        )
        
        return router
    }
}


protocol AppRootInteractable: ArtworkListener, PostingListener { }

final class AppRootInteractor: AppRootInteractable {}

protocol AppRootRouting {
    func configureTabs() -> [UIViewController]
}

final class AppRootRouter: AppRootRouting {
    
    var interactor: AppRootInteractable?
    
    private let artworkBuildable: ArtworkViewBuildable
    private var artworkRouting: ArtworkRouting?
    
    private let postingBuildable: PostingViewBuildable
    private var postingRouting: PostingRouting?
    
    init(
        interactor :AppRootInteractable,
        artworkBuildable: ArtworkViewBuildable,
        postingBuildable: PostingViewBuildable
    ) {
        self.interactor = interactor
        
        self.artworkBuildable = artworkBuildable
        self.postingBuildable = postingBuildable
    }
    
    func configureTabs() -> [UIViewController] {
        let artworkRouting = artworkBuildable.build(with: interactor)
        self.artworkRouting = artworkRouting
        
        let postingRouting = postingBuildable.build(with: interactor)
        self.postingRouting = postingRouting
        
        let viewControllers = [
            artworkRouting.viewController,
            postingRouting.viewController
        ]
        
        return viewControllers
    }
}


protocol AppRootTabBarControllable {
    func setViewControllers(_ viewControllers: [UIViewController])
    func build() -> UITabBarController
}

final class AppRootTabBarController: UITabBarController, AppRootTabBarControllable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        tabBar.backgroundColor = .green
        
        print(self.tabBar.frame.height)
    }
    
    func setViewControllers(_ viewControllers: [UIViewController]) {
        super.setViewControllers(viewControllers, animated: false)
    }
    
    func build() -> UITabBarController {
        return self
    }
}



// MARK: - PageViewController
import SnapKit
import SwiftUI

final class AppRootContainerViewController: UIViewController {
    
    // MARK: - Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
    private let statusBar: UIView = {
        let statusBar = ZiineStatusBar()
        let hostingController = UIHostingController(rootView: statusBar)
        return hostingController.view!
    }()
    
    private lazy var pagerView: UIView = {
        let pageViewController = AppRootPageViewController()
        pageViewController.didMove(toParent: self)
        return pageViewController.view!
    }()
    
    private func configureUI() {
        view.addSubview(statusBar)
        statusBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(65)
        }
        
        view.addSubview(pagerView)
        pagerView.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}


final class AppRootPageViewController: UIPageViewController {
    
    private var pages: [UIViewController] = []
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("didCall")
        self.dataSource = self
        
        // 두 개의 뷰 컨트롤러 추가
        let firstVC = UIViewController()
        firstVC.view.backgroundColor = .systemBlue
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .green
        pages = [firstVC, secondVC]
        
        // 초기 페이지 설정
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: false, completion: nil)
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension AppRootPageViewController: UIPageViewControllerDataSource {
    
    // 이전 페이지 반환
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }
    
    // 다음 페이지 반환
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
}


