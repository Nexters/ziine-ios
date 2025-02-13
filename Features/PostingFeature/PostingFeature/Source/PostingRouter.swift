//
//  PostingRouter.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import CommonUI
import PostingFeatureInterface

final class PostingRouter: PostingRouting {
    
    var viewController: UIViewController 
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    /// 업로드 화면 푸시
    func pushUploadView() {
        self.viewController.navigationController?.pushViewController(UploadViewController(), animated: true)
    }
}
