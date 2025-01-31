//
//  Interface.swift
//  PostingFeatureInterface
//
//  Created by Geon Woo lee on 1/29/25.
//

import UIKit

public protocol PostingListener: AnyObject { }

public protocol PostingViewBuildable {
    func build(with listener: PostingListener?) -> PostingRouting
}

public protocol PostingRouting: AnyObject {
    var viewController: UIViewController { get }
    
    func pushUploadView()
}
