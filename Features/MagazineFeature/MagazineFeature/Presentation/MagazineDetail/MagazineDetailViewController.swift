//
//  MagazineDetailViewController.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/14/25.
//

import UIKit
import CommonUI
import DesignSystem
internal import SnapKit
import MagazineFeatureInterface

protocol MagazineDetailViewPresentableListener: AnyObject { }

public final class MagazineDetailViewController: UIViewController {
    
    var listener: MagazineDetailViewPresentableListener?
    
    // MARK: - Initialize
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        navigationItem.leftBarButtonItem = .init(image: ZiineImage.uiImage(.directionLeft).withTintColor(.white), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UIComponents
    
    private let webView: ZiineWebViewPresentable = ZiineWebView()
    
    private func configureUI() {
        let webView = webView.getView()
        webView.backgroundColor = ZiineColor.uiColor(.g900)
        
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MagazineDetailViewController: MagazineDetailViewPresentable {
    func loadWebView(urlString: String) {
        webView.loadWebView(urlString: urlString)
    }
}

extension MagazineDetailViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
