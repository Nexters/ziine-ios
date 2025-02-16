//
//  CollectionUI.swift
//  ListKit
//
//  Created by Geon Woo lee on 2/2/25.
//

import UIKit

public final class CollectionUI: UICollectionView {
    
    weak var listener: CollectionUIListener?
    
    private var sections: [CollectionUISection] = []
    
    public func configure(sections: [CollectionUISection]) {
        self.sections = sections
        
        self.reloadData()
    }

    public init(
        collectionViewLayout layout: UICollectionViewLayout = UICollectionViewFlowLayout(),
        listener: CollectionUIListener? = nil
    ) {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.listener = listener
        
        self.delegate = self
        self.dataSource = self
        
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.register(ArtworkCell.self, forCellWithReuseIdentifier: ArtworkCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionUI: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .horizontalScroll:
            return 1
        case .default:
            return sections[section].items.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        let cell = item.buildable.collectionView(collectionView, cellForItemAt: indexPath)
        
        return cell
    }
}

extension CollectionUI: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        
        item.buildable.collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listener?.scrollViewDidScroll(scrollView)
    }
}

extension CollectionUI: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        let size = item.buildable.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)

        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let current = sections[section]
        let item = current.items.first
        let insets = item?.buildable.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: section) ?? .zero
        
        return insets
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let current = sections[section]
        let item = current.items.first
        let value = item?.buildable.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section) ?? .zero
        
        return value
    }
}
