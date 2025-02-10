//
//  ArtworkRouter.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ArtworkFeatureInterface
import PostingFeatureInterface

final class ArtworkRouter: ArtworkRouting {
    
    var viewController: UIViewController 
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
