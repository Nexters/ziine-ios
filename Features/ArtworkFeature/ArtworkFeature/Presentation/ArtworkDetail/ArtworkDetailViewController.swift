//
//  ArtworkDetailViewController.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/11/25.
//

import UIKit
import CommonUI
import DesignSystem
internal import SnapKit
import ArtworkFeatureInterface

protocol ArtworkDetailViewPresentableListener: AnyObject {
}

public final class ArtworkDetailViewController: UIViewController {
    
    var listener: ArtworkDetailViewPresentableListener?
    
    // MARK: - Initialize
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationItem.leftBarButtonItem = .init(image: ZiineImage.uiImage(.directionLeft).withTintColor(.white), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UIComponents
    
    private lazy var webView = {
        let wv = ZiineWebView(listener: self)
        return wv
    }()
    
    private func configureUI() {
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ArtworkDetailViewController: ArtworkDetailViewPresentable {
    func loadWebView(urlString: String) {
        webView.loadWebView(urlString: urlString)
    }
}

extension ArtworkDetailViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ArtworkDetailViewController: ZiineWebViewListener {
    
}
