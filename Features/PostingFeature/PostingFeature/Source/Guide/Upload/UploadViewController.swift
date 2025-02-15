//
//  UploadViewController.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 1/30/25.
//

import UIKit
import CommonUI
import DesignSystem

final class UploadViewController: UIViewController {
    
    // MARK: - Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
        load()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewIsAppearing(_ animated: Bool) {
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
        view.backgroundColor = ZiineColor.uiColor(.g900)
        
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func load() {
        webView.loadWebView(urlString: "https://www.ziine.gallery/artwork/register")
    }
}

extension UploadViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension UploadViewController: ZiineWebViewListener {
    
}
