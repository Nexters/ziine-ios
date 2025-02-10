//
//  ArtworkDetailInteractorable.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/11/25.
//

import ArtworkFeatureInterface

protocol ArtworkDetailInteractorable: AnyObject {
    var router: ArtworkDetailRouting? { get set }
    var listener: ArtworkDetailListener? { get set }
}

protocol ArtworkDetailViewPresentable: AnyObject {
    var listener: ArtworkDetailViewPresentableListener? { get set }
    
    func loadWebView(urlString: String)
}

final class ArtworkDetailInteractor:
    ArtworkDetailInteractorable,
    ArtworkDetailViewPresentableListener
{
    var router: ArtworkDetailRouting?
    var listener: ArtworkDetailListener?
    var presenter: ArtworkDetailViewPresentable?
    
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

