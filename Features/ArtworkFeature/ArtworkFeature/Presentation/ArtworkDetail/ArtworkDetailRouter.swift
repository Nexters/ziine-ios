//
//  ArtworkDetailRouter.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/11/25.
//

import UIKit
import ArtworkFeatureInterface

public final class ArtworkDetailRouter: ArtworkDetailRouting {
    public var viewController: UIViewController
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
