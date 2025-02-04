//
//  MagazineCarouselLayout.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/4/25.
//

import UIKit

final class MagazineCarouselLayout: UICollectionViewFlowLayout {
    
    private var sideItemScale: CGFloat = 0.8
    private var sideItemAlpha: CGFloat = 0.5
    private var spacing: CGFloat = 10

    private var isSetup: Bool = false
    
    override func prepare() {
        super.prepare()
        if isSetup == false {
            setupLayout()
            isSetup = true
        }
    }
    
    private func setupLayout() {
        guard let collectionView = self.collectionView else { return }
        
        let collectionViewSize = collectionView.bounds.size
        let xInset = (collectionViewSize.width - self.itemSize.width) / 2
        let yInset = (collectionViewSize.height - self.itemSize.height) / 2
        
        self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
        self.minimumLineSpacing = spacing

        self.scrollDirection = .horizontal
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect)?.map({ $0.copy() as! UICollectionViewLayoutAttributes }) else { return nil }
        
        return attributes.map { transformLayoutAttributes($0) }
    }

    private func transformLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = collectionView else { return attributes }
        
        let collectionCenter = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = attributes.center.x - contentOffset
        
        let distance = abs(collectionCenter - center)
        let scale = max(sideItemScale, 1 - distance / collectionView.frame.width)
        
        attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        return attributes
    }
}
