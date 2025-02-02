//
//  AppRootInteractable.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 2/2/25.
//

import UIKit
import ArtworkFeatureInterface
import PostingFeatureInterface

protocol AppRootInteractable: ArtworkListener, PostingListener {
    func onChange(statusBarItem: ZiinStatusTabBarItem)
}

final class AppRootInteractor:
    AppRootInteractable,
    AppRootContainerViewPresentableListener
{
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
