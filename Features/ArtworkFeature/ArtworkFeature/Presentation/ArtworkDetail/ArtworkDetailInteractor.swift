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
}

final class ArtworkDetailInteractor:
    ArtworkDetailInteractorable,
    ArtworkDetailViewPresentableListener
{
    var router: ArtworkDetailRouting?
    var listener: ArtworkDetailListener?
    var presenter: ArtworkDetailViewPresentable?
    
}

