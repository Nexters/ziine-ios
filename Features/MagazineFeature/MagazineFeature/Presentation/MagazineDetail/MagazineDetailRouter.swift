//
//  MagazineDetailRouter.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/14/25.
//

import UIKit
import MagazineFeatureInterface

public final class MagazineDetailRouter: MagazineDetailRouting {
    public var viewController: UIViewController
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
