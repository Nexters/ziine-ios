//
//  MagazineDetailInteractor.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/14/25.
//

import MagazineFeatureInterface

protocol MagazineDetailInteractorable: AnyObject {
    var router: MagazineDetailRouting? { get set }
    var listener: MagazineDetailListener? { get set }
}

protocol MagazineDetailViewPresentable: AnyObject {
    var listener: MagazineDetailViewPresentableListener? { get set }
    func loadWebView(urlString: String)
}

final class MagazineDetailInteractor:
    MagazineDetailInteractorable,
    MagazineDetailViewPresentableListener
{
    var router: MagazineDetailRouting?
    var listener: MagazineDetailListener?
    var presenter: MagazineDetailViewPresentable?
    
    private var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func didBecomeActive() {
        loadWebView()
    }
    
    private func loadWebView() {
        presenter?.loadWebView(urlString: urlString)
    }
}
