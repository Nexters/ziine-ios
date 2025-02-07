//
//  MagazineCarouselLayout.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/4/25.
//

import UIKit

final class MagazineCarouselLayout: UICollectionViewFlowLayout {
    
    private var sideItemScale: CGFloat = 0.9
    private var spacing: CGFloat = 16

    private var isSetup: Bool = false
    
    override func prepare() {
        super.prepare()
        
        if isSetup == false {
            setupLayout()
            isSetup = true
        }
    }
    
    private func setupLayout() {
        guard let collectionView = collectionView else { return }
        
        let collectionViewSize = collectionView.bounds.size
        let itemWidth = collectionViewSize.width * 0.8
        let itemHeight = collectionViewSize.height
        
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let xInset = (collectionViewSize.width - itemWidth) / 2
        self.sectionInset = UIEdgeInsets(top: 0, left: xInset, bottom: 0, right: xInset)
        
        self.minimumLineSpacing = spacing
        self.scrollDirection = .horizontal
    }
}
