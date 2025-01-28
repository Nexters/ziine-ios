//
//  AppRootBuildable.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 1/29/25.
//

import UIKit
import ArtworkFeature
import ArtworkFeatureInterface

final class AppRootBuilder {
    
    func build() -> AppRootRouter {
        let artworkBuilder = ArtworkViewBuilder()  
        let router = AppRootRouter(artworkBuildable: artworkBuilder)
        
        return router
    }
}

final class AppRootRouter {
    
    let artworkBuildable: ArtworkViewBuildable
    var artworkRouting: ArtworkRouting?
    
    init(artworkBuildable: ArtworkViewBuildable) {
        self.artworkBuildable = artworkBuildable
        self.artworkRouting = artworkBuildable.build(with: nil)
    }
}
