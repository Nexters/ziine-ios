//
//  AppRootContainerViewPresentable.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 2/2/25.
//

import UIKit
import SwiftUI

// MARK: - PageViewController

protocol AppRootViewPresentable {
    func set(page: UIViewController)
}

protocol AppRootViewPresentableListener {
    func onChange(statusBarItem: ZiinStatusTabBarItem)
}

final class AppRootViewController: UIViewController,
                                   AppRootViewPresentable
{
    var listener: AppRootViewPresentableListener?
    
    // MARK: - Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
    private lazy var statusBar: UIView = {
        let statusBar = ZiineStatusBar { [weak self] action in
            switch action {
            case let .onChange(statusBarItem):
                self?.listener?.onChange(statusBarItem: statusBarItem)
            }
        }
        
        let hostingController = UIHostingController(rootView: statusBar)
        return hostingController.view!
    }()
    
    private lazy var pageViewController: AppRootPageViewController = {
        let pageViewController = AppRootPageViewController()
        pageViewController.didMove(toParent: self)
        return pageViewController
    }()
    
    private func configureUI() {
        let navigationBarHeight = 44
        
        view.addSubview(statusBar)
        statusBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-navigationBarHeight)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(65)
        }
        
        let pagerView = pageViewController.view!
        view.addSubview(pagerView)
        pagerView.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func set(page: UIViewController) {
        pageViewController.setViewController(page: page)
    }
}
