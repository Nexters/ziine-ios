//
//  Interface.swift
//  ArtworkFeatureInterface
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ListKit

public protocol ArtworkListener: AnyObject {
    func addButtonTapped()
    func artworkDetail(dataModel: ArtworkModel)
}

public protocol ArtworkViewBuildable {
    func build(with listener: ArtworkListener?) -> ArtworkRouting
}

public protocol ArtworkRouting: AnyObject {
    var viewController: UIViewController { get }
}
