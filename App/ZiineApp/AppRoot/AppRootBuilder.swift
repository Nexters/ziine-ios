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



struct ZiineTabBarItem {
    var tag: Int
    var image: UIImage
    var selectedImage: UIImage
}

final class ZiineTabView: UIView {
    
    private var tabBarItems: [ZiineTabBarItem] = []
    private var uiButtons: [UIButton] = []
    
    // MARK: - Initialize
    
    init() {
        self.tabBarItems = [
            .init(tag: 0, image: .actions, selectedImage: .actions),
            .init(tag: 1, image: .add, selectedImage: .add)
        ]
        
        var buttons: [UIButton] = []
        tabBarItems.forEach { tabBarItem in
            let button = UIButton()
            button.setImage(tabBarItem.image, for: .normal)
            button.setImage(tabBarItem.selectedImage, for: .selected)
            
            buttons.append(button)
        }
        
        self.uiButtons = buttons
        
        super.init(frame: .zero)
        
        uiButtons.forEach { button in
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
        
        configureUI()
    }
    
    @objc func didTapButton() { }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
    private let stackView: UIStackView = {
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private func configureUI() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
