//
//  ZiineLottieView.swift
//  CommonUI
//
//  Created by 이건우 on 2/15/25.
//

import UIKit
import ThirdParty
import Lottie

// FIXME: Bundle
extension Bundle {
    static var current: Bundle {
        class __ { }
        return Bundle(for: __.self)
    }
}

// 외부 모듈에 제공 SDK
public protocol ZiineLottieViewPresentable {
    func getView() -> UIView
    func play(completion: @escaping () -> Void)
    func stop()
}

public class ZiineLottieView: UIView, ZiineLottieViewPresentable {
    private let animationView: LottieAnimationView
    private var width: CGFloat
    private var height: CGFloat
    
    public init(
        assetName: String,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        loopMode: LottieLoopMode = .loop,
        width: CGFloat = 100,
        height: CGFloat = 100
    ) {
        self.animationView = LottieAnimationView(name: assetName, bundle: .current)
        self.width = width
        self.height = height
        super.init(frame: .zero)
        
        setupView(contentMode: contentMode, loopMode: loopMode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(
        contentMode: UIView.ContentMode,
        loopMode: LottieLoopMode
    ) {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = loopMode
        animationView.contentMode = contentMode
        
        addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            animationView.widthAnchor.constraint(equalToConstant: width),
            animationView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    public func getView() -> UIView {
        return self
    }
    
    /// 애니메이션 시작
    public func play(completion: @escaping () -> Void) {
        animationView.play { finished in
            if finished {
                completion()
            }
        }
    }
    
    /// 애니메이션 정지
    public func stop() {
        animationView.stop()
    }
}
