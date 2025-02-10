//
//  UploadViewController.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 1/30/25.
//

import UIKit
import CommonUI

final class UploadViewController: UIViewController {
    
    // MARK: - Initialize
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
    private let webView: ZiineWebViewPresentable = ZiineWebView()
    
    private func configureUI() {
        let webView = webView.getView()
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func load() {
        webView.loadWebView(urlString: "https://www.naver.com")
    }
}

