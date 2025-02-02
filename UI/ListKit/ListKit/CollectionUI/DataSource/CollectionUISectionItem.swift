//
//  CollectionUISectionItem.swift
//  ListKit
//
//  Created by Geon Woo lee on 2/2/25.
//

enum CollectionUISectionItem {
    case artworkThumbnail(CollectionUIBuildable)
    
    var buildable: CollectionUIBuildable {
        switch self {
        case let .artworkThumbnail(buildable):
            return buildable
        }
    }
}
