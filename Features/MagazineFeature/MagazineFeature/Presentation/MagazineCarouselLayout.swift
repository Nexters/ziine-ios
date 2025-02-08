//
//  MagazineCarouselLayout.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/4/25.
//

import UIKit

final class MagazineCarouselLayout: UICollectionViewFlowLayout {
    
    private var sideItemScale: CGFloat = 0.9
    private var spacing: CGFloat = 8
    
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
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
        else { return nil }
        
        return attributes.map({ self.transformLayoutAttributes(attributes: $0) })
    }
    
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        
        guard let collectionView = self.collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        guard let collectionView = self.collectionView else { return attributes }
        
        let collectionCenter = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = attributes.center.x - contentOffset
        
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - center), maxDistance)
        
        let ratio = (maxDistance - distance)/maxDistance
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let dist = attributes.frame.midX - visibleRect.midX
        var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        transform = CATransform3DTranslate(transform, 0, 0, -abs(dist / 1000))
        attributes.transform3D = transform
        
        return attributes
    }
}
