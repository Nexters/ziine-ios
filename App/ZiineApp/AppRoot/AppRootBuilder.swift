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

import SwiftUI
import DesignSystem

struct ZiineStatusBar: View {
    @State private var selectedTab: Tab = .artworks
    @Namespace private var animationNamespace // 매끄러운 애니메이션을 위한 네임스페이스

    enum Tab: CaseIterable {
        case artworks, magazine
        
        var labelValue: String {
            switch self {
            case .artworks:
                return "Artworks"
            case .magazine:
                return "Magazine"
            }
        }
        
        
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                } label: {
                    Text(tab.labelValue)
                        .font(Font(ZiineFont.s2))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            ZStack {
                                if selectedTab == tab {
                                    Capsule()
                                        .fill(ZiineColor.color(.p500))
                                        .matchedGeometryEffect(id: "slider", in: animationNamespace)
                                }
                            }
                        )
                        .foregroundColor(
                            selectedTab == tab
                            ? ZiineColor.color(.g900)
                            : ZiineColor.color(.g600)
                        )
                }
            }
        }
        .frame(height: 40)
    }
}

#Preview {
    ZiineStatusBar()
}
