//
//  AppRootBuildable.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 1/29/25.
//

import UIKit
import ArtworkFeature
import ArtworkFeatureInterface

protocol AppRootBuildable {
    
}

final class AppRootBuilder: AppRootBuildable {
    
    func build() -> AppRootRouting {
        let artworkBuilder = ArtworkViewBuilder()
        let router = AppRootRouter(artworkBuildable: artworkBuilder)
        
        return router
    }
}

protocol AppRootRouting {
    var artworkRouting: ArtworkRouting? { get }
}

final class AppRootRouter: AppRootRouting {
    
    private let artworkBuildable: ArtworkViewBuildable
    var artworkRouting: ArtworkRouting?
    
    init(artworkBuildable: ArtworkViewBuildable) {
        self.artworkBuildable = artworkBuildable
        self.artworkRouting = artworkBuildable.build(with: nil)
    }
}
