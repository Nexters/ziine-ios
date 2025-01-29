//
//  ArtworkInteractor.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ArtworkFeatureInterface

protocol ArtworkViewPresentable: AnyObject {
    var listener: ArtworkViewPresentableListener? { get set }
}

protocol ArtworkInteractorable: AnyObject {
    var router: ArtworkRouting? { get set }
    var listener: ArtworkListener? { get set }
}

protocol ArtworkInteractorDependency: AnyObject { }

final class ArtworkInteractor:
    ArtworkInteractorable,
    ArtworkViewPresentableListener
{
    var router: ArtworkRouting?
    var listener: ArtworkListener?
    
    init() {}
    
    func fetch() { }
    
    func itemSelected(indexPath: IndexPath) {
        router?.pushToUpload()
    }
}
