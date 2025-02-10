//
//  ArtworkDetailInterface.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/11/25.
//

import UIKit

public protocol ArtworkDetailListener: AnyObject {}

public protocol ArtworkDetailViewBuildable {
    func build(with listener: ArtworkDetailListener?) -> ArtworkDetailRouting
}

public protocol ArtworkDetailRouting: AnyObject {
    var viewController: UIViewController { get }
}
