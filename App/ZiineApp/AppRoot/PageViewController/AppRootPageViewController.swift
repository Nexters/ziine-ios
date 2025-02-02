//
//  AppRootPageViewControllable.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 2/2/25.
//

import UIKit

protocol AppRootPageViewControllable {
    func setViewController(page: UIViewController)
}

final class AppRootPageViewController: UIPageViewController, AppRootPageViewControllable {
    
    // MARK: - Initialize
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// `setViewController` 설정
    func setViewController(page: UIViewController) {
        setViewControllers([page], direction: .forward, animated: false, completion: nil)
    }
}
