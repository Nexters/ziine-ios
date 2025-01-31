//
//  PostingInteractor.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import PostingFeatureInterface

protocol PostingViewPresentable: AnyObject {
    var listener: PostingViewPresentableListener? { get set }
}

protocol PostingInteractorable: AnyObject {
    var router: PostingRouting? { get set }
    var listener: PostingListener? { get set }
}

protocol PostingInteractorDependency: AnyObject { }

final class PostingInteractor:
    PostingInteractorable,
    PostingViewPresentableListener
{
    var router: PostingRouting?
    var listener: PostingListener?
    
    init() {}
    
    func uploadButtonTapped() {
        router?.pushUploadView()
    }
}
