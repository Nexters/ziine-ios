//
//  CollectionUIDataSource.swift
//  ListKit
//
//  Created by Geon Woo lee on 2/2/25.
//

import UIKit

protocol CollectionUIDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}
