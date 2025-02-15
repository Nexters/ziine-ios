//
//  ZiineLottieView.swift
//  CommonUI
//
//  Created by 이건우 on 2/15/25.
//

import UIKit
import ThirdParty
internal import Lottie

// 외부 모듈에 제공 SDK
public protocol ZiineLottieViewPresentable {
    func getView() -> UIView
    func play()
    func stop()
}

public class ZiineLottieView: UIView, ZiineLottieViewPresentable {
    
    private let animationView: LottieAnimationView
    private let withBackground: Bool
    private let backgroundView = UIView()
    
    init(
        assetName: String,
        withBackground: Bool = false,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        loopMode: LottieLoopMode = .loop,
        completion: (() -> Void)? = nil
    ) {
        self.animationView = LottieAnimationView(name: assetName)
        self.withBackground = withBackground
        super.init(frame: .zero)
        
        setupView(contentMode: contentMode, loopMode: loopMode, completion: completion)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(
        contentMode: UIView.ContentMode,
        loopMode: LottieLoopMode,
        completion: (() -> Void)?
    ) {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = loopMode
        animationView.contentMode = contentMode
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = withBackground ? UIColor.gray.withAlphaComponent(0.6) : .clear
        
        addSubview(backgroundView)
        addSubview(animationView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationView.widthAnchor.constraint(equalTo: widthAnchor),
            animationView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
        animationView.play { finished in
            if finished {
                completion?()
            }
        }
    }
    
    public func getView() -> UIView {
        return self
    }
    
    /// 애니메이션 시작
    public func play() {
        animationView.play()
    }
    
    /// 애니메이션 정지
    public func stop() {
        animationView.stop()
    }
}
