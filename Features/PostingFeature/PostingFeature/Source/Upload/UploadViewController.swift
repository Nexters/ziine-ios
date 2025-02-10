//
//  UploadViewController.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 1/30/25.
//

import UIKit
import WebKit

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

public protocol ZiineWebViewPresentable: AnyObject {
    func getView() -> UIView
    func loadWebView(urlString: String)
}

public final class ZiineWebView: UIView, ZiineWebViewPresentable {
    
    public func getView() -> UIView {
        webView
    }
    
    public func loadWebView(urlString: String) {
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            
            webView.load(urlRequest)
        }
    }
    
    // MARK: - Initialize
    
    public init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
    private let webView = WKWebView()
    
    private func configureUI() {
        addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
