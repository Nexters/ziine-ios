//
//  CollectionUIDelegate.swift
//  ListKit
//
//  Created by Geon Woo lee on 2/2/25.
//

import UIKit

public protocol CollectionUIDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

public extension CollectionUIDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}
