//
//  MagazineDetailInterface.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/14/25.
//

import UIKit

public protocol MagazineDetailListener: AnyObject {}

public protocol MagazineDetailViewBuildable {
    func build(
        urtString: String,
        with listener: MagazineListener?
    ) -> MagazineDetailRouting?
}

public protocol MagazineDetailRouting: AnyObject {
    var viewController: UIViewController { get }
}
