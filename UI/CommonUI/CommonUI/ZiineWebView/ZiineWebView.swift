//
//  ZiineWebViewPresentable.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 2/11/25.
//

import UIKit
import WebKit
import DesignSystem
internal import SnapKit

/// 웹에서 떨어지는 이벤트에 대한 약속
public enum ZiineWebViewJavaScriptEventProtocol {
    /// 시스템 공유하기
    case systemSharing(string: String)
}

public protocol ZiineWebViewListener: AnyObject {
    func event(_ event: ZiineWebViewJavaScriptEventProtocol)
}

public extension ZiineWebViewListener {
    func event(_ event: ZiineWebViewJavaScriptEventProtocol) {}
}

public final class ZiineWebView: UIView {
    
    public typealias Listener = ZiineWebViewListener
    
    private var listener: Listener?
    
    public func loadWebView(urlString: String) {
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            
            webView.load(urlRequest)
        }
    }
    
    // MARK: - Initialize
    
    public init(listener: Listener?) {
        self.listener = listener
        
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents

    /// 웹뷰 객체
    private lazy var webView: WKWebView = {
        $0.uiDelegate = self
        $0.navigationDelegate = self
        $0.isHidden = true
        $0.backgroundColor = ZiineColor.uiColor(.g900)
        return $0
    }(WKWebView())
    
    private func configureUI() {
        backgroundColor = ZiineColor.uiColor(.g900)
        
        addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ZiineWebView: WKScriptMessageHandler,
                        WKUIDelegate,
                        WKNavigationDelegate {
    
    /// 웹뷰가 로드가 끝난 시점에 호출
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("🐼", #function)
        webView.isHidden = false
        
//        webView.evaluateJavaScript("") { message, error in
//            print("🐼🐼🐼🐼",message, error?.localizedDescription)
//        }
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("🐼", #function)
    }
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        webView.isHidden = true
        print("🐼", #function)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences) async -> (WKNavigationActionPolicy, WKWebpagePreferences) {
        print("🐼", #function)
        return (.allow, preferences)
    }
}
