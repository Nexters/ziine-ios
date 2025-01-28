//
//  ArtworkRouter.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ArtworkFeatureInterface

final class ArtworkRouter: ArtworkRouting {
    
    private let navigationController: UINavigationController
    var viewController: UIViewController
    
    init(
        navigationController: UINavigationController,
        viewController: UIViewController
    ) {
        self.navigationController = navigationController
        self.viewController = viewController
    }
    
    // MARK: - Upload
    
    func pushToUpload() {
        print(#function)
        
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBlue
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
