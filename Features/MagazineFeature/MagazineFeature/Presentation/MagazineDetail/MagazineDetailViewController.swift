//
//  MagazineDetailViewController.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/14/25.
//

import UIKit
import CommonUI
internal import SnapKit
import MagazineFeatureInterface

protocol MagazineDetailViewPresentableListener: AnyObject { }

public final class MagazineDetailViewController: UIViewController {
    
    var listener: MagazineDetailViewPresentableListener?
    
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

extension MagazineDetailViewController: MagazineDetailViewPresentable {
    func loadWebView(urlString: String) {
        webView.loadWebView(urlString: "https://www.naver.com")
    }
}
