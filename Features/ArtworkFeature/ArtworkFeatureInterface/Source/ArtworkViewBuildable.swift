//
//  ArtworkViewBuildable.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit

public protocol ArtworkListener: AnyObject { }

public protocol ArtworkViewBuildable {
    func build(withListener listener: ArtworkListener?) -> ArtworkRouting
}

public protocol ArtworkRouting: AnyObject {
    var viewController: UIViewController? { get }
    
    func pushToUpload()
}
