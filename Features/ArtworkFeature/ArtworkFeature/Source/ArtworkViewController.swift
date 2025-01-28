//
//  ArtworkViewController.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import ArtworkFeatureInterface

protocol ArtworkViewPresentableListener: AnyObject {
    func itemSelected(indexPath: IndexPath)
}

final class ArtworkViewController: UIViewController,
                                   ArtworkViewPresentable,
                                   UICollectionViewDelegate
{
    weak var listener: ArtworkViewPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
        
        listener?.itemSelected(indexPath: .init(row: 0, section: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
//    private let collectionView = UICollectionView()
    
    private func configureUI() {
        // TODO: - 스냅킷 도입 예정
        
        view.backgroundColor = .red
    }
    
    // TODO: - 컬렉션 UI 도입해서 분리할 예정
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        listener?.itemSelected(indexPath: indexPath)
//    }
}
