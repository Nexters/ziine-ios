//
//  SplashViewController.swift
//  ZiineApp
//
//  Created by 이건우 on 2/15/25.
//

import UIKit
import CommonUI
import DesignSystem

internal import SnapKit
internal import Lottie

protocol SplashViewControllerListener: AnyObject {
    func didCompleteSplash()
}

class SplashViewController: UIViewController {
    typealias Listener = SplashViewControllerListener
    
    weak var listener: Listener?
    
    init(listener: Listener?) {
        self.listener = listener
        
        super.init(nibName: nil, bundle: nil)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.view.backgroundColor = ZiineColor.uiColor(.p500)
        
        view.addSubview(splashLottieView.getView())
        splashLottieView.getView().snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private lazy var splashLottieView: ZiineLottieViewPresentable = {
        let view = ZiineLottieView(
            assetName: "splash",
            contentMode: .scaleAspectFit,
            loopMode: .playOnce,
            width: 222, height: 110
        )
        view.play() {
            self.listener?.didCompleteSplash()
        }
        return view
    }()
}
