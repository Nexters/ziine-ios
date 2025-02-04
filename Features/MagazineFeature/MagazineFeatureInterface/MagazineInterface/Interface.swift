//
//  Interface.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/4/25.
//

import UIKit

public protocol MagazineListener: AnyObject { }

public protocol MagazineViewBuildable {
    func build(with listener: MagazineListener?) -> MagazineRouting
}

public protocol MagazineRouting: AnyObject {
    var viewController: UIViewController { get }
    
    func pushToDetailView()
}
