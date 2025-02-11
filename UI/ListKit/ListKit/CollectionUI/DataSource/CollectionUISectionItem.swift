//
//  CollectionUISectionItem.swift
//  ListKit
//
//  Created by Geon Woo lee on 2/2/25.
//

public enum CollectionUISectionItem {
    case artworkThumbnail(CollectionUIBuildable)
    
    public var buildable: CollectionUIBuildable {
        switch self {
        case let .artworkThumbnail(buildable):
            return buildable
        }
    }
}
