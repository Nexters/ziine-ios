//
//  MagazineCarouselLayout.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/4/25.
//

import UIKit

final class MagazineCarouselLayout: UICollectionViewFlowLayout {
    private var isSetup: Bool = false
    
    override func prepare() {
        super.prepare()
        
        if !isSetup {
            setupLayout()
            isSetup = true
        }
    }
    
    private func setupLayout() {
        guard let collectionView = collectionView else { return }
        
        let collectionViewSize = collectionView.bounds.size
        let itemWidth = collectionViewSize.width * CarouselConstants.visibleItemWidth
        let itemHeight = collectionViewSize.height
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let xInset = (collectionViewSize.width - itemWidth) / 2
        sectionInset = UIEdgeInsets(top: 0, left: xInset, bottom: 0, right: xInset)
        
        minimumLineSpacing = CarouselConstants.spacing
        scrollDirection = .horizontal
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
        else { return nil }
        
        return attributes.map { transformLayoutAttributes(attributes: $0) }
    }
    
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(
                forProposedContentOffset: proposedContentOffset,
                withScrollingVelocity: velocity
            )
        }
        
        let targetRect = CGRect(
            x: proposedContentOffset.x,
            y: 0,
            width: collectionView.frame.width,
            height: collectionView.frame.height
        )
        
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else {
            return .zero
        }
        
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        let offsetAdjustment = rectAttributes
            .map { abs($0.center.x - horizontalCenter) }
            .enumerated()
            .min(by: { $0.element < $1.element })
            .map { rectAttributes[$0.offset].center.x - horizontalCenter } ?? 0
        
        return CGPoint(
            x: proposedContentOffset.x + offsetAdjustment,
            y: proposedContentOffset.y
        )
    }
    
    private func transformLayoutAttributes(
        attributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        guard let collectionView = collectionView else { return attributes }
        
        let collectionCenter = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = attributes.center.x - contentOffset
        
        let maxDistance = itemSize.width + minimumLineSpacing
        let distance = min(abs(collectionCenter - center), maxDistance)
        let ratio = (maxDistance - distance) / maxDistance
        let scale = ratio * (1 - CarouselConstants.sideItemScale) + CarouselConstants.sideItemScale
        
        let visibleRect = CGRect(
            origin: collectionView.contentOffset,
            size: collectionView.bounds.size
        )
        
        let dist = attributes.frame.midX - visibleRect.midX
        var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        transform = CATransform3DTranslate(transform, 0, 0, -abs(dist / 1000))
        attributes.transform3D = transform
        
        return attributes
    }
}

// MARK: - Clamping Extension
extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
