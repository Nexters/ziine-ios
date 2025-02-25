//
//  AppRootInteractable.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 2/2/25.
//

import UIKit
import ListKit
import ArtworkFeatureInterface
import PostingFeatureInterface
import MagazineFeatureInterface

protocol AppRootInteractable: ArtworkListener, PostingListener, MagazineListener {
    func onChange(statusBarItem: ZiinStatusTabBarItem)
}

final class AppRootInteractor:
    AppRootInteractable,
    AppRootViewPresentableListener
{
    var router: AppRootRouting?
    var presenter: AppRootViewPresentable?
    
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
 
    func addButtonTapped() {
        router?.pushToPostingGuide()
    }
    
    func artworkDetail(dataModel: ArtworkModel) {
        let urlString = "https://www.ziine.gallery/artwork-webview/\(dataModel.id)"
        router?.pushToArtworkDetail(urlString: urlString)
    }
    
    func magazineDetail(dataModel: MagazineModel) {
        let urlString = "https://www.ziine.gallery/magazine-webview/\(dataModel.id)"
        router?.pushToMagazineDetail(urlString: urlString)
    }
}
