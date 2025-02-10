//
//  ArtworkDetailViewController.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/11/25.
//

import UIKit
import CommonUI
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
    
    // MARK: - UIComponents
    
    private let webView: ZiineWebViewPresentable = ZiineWebView()
    
    private func configureUI() {
        let webView = webView.getView()
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ArtworkDetailViewController: ArtworkDetailViewPresentable {
    func loadWebView(urlString: String) {
        print(#function)
        webView.loadWebView(urlString: "https://www.naver.com")
    }
}
