//
//  ArtworkCellUIBuilderListener.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/13/25.
//

import ListKit
import UIKit

protocol ArtworkCellUIBuilderListener: AnyObject {
    func modelSelected(dataModel: ListDataModel)
}

final class ArtworkCellUIBuilder: CollectionUIBuildable {
    typealias Listener = ArtworkCellUIBuilderListener
    
    weak var listener: Listener?
    
    var dataModel: ListDataModel?
    
    func configure(dataModel: ListDataModel, listener: Listener?) {
        self.dataModel = dataModel
        self.listener = listener
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ArtworkCell.id,
            for: indexPath
        ) as? ArtworkCell else {
            return .init()
        }
        
        guard let dataModel else { return .init() }
        
        cell.configure(dataModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let inset: CGFloat = 16.0
        
        let length = screenWidth - (inset * 2)
        
        return .init(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: 16, left: 0, bottom: 80, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataModel else { return }
        listener?.modelSelected(dataModel: dataModel)
    }
    
}
