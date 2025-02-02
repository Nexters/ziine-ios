//
//  ArtworkRouter.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ArtworkFeatureInterface

final class ArtworkRouter: ArtworkRouting {
    
    var viewController: UIViewController 
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Upload
    
    func pushToUpload() {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemBlue
//        navigationController.pushViewController(viewController, animated: true)
        viewController.present(vc, animated: true)
//        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
}
