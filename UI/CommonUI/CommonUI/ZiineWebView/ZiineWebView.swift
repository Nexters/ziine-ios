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
    /// 업로드 종료
    case didFinishUpload
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
        let v = WKUserContentController()
        v.add(self, name: "callbackHandler")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = v
        
        let wv = WKWebView(frame: .zero, configuration: configuration)
        wv.uiDelegate = self
        wv.navigationDelegate = self
        wv.isHidden = true
        wv.backgroundColor = ZiineColor.uiColor(.g900)
        return wv
    }()
    
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
        
        // 줌 방지
        let zoomDisableScript = """
            var meta = document.createElement('meta');
            meta.name = 'viewport';
            meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
            document.getElementsByTagName('head')[0].appendChild(meta);
            """
        
        webView.evaluateJavaScript(zoomDisableScript, completionHandler: nil)
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("🐼", #function, message)
        
        listener?.event(.didFinishUpload)
    }
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        webView.isHidden = true
        print("🐼", #function)
    }
    
    public func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        preferences: WKWebpagePreferences
    ) async -> (WKNavigationActionPolicy, WKWebpagePreferences) {
        print("🐼", #function)
        return (.allow, preferences)
    }
}
