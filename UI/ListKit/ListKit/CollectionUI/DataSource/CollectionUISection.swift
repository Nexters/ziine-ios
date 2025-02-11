//
//  CollectionUISection.swift
//  ListKit
//
//  Created by Geon Woo lee on 2/2/25.
//

public enum CollectionUISection {
    case `default`([CollectionUISectionItem])
    case horizontalScroll(CollectionUISectionItem)
    
    public init(original: CollectionUISection) {
        switch original {
        case let .default(items):
            self = .default(items)
        case let .horizontalScroll(items):
            self = .horizontalScroll(items)
        }
    }
    
    public var items: [CollectionUISectionItem] {
        switch self {
        case let .default(items):
            return items
        case let .horizontalScroll(item):
            return [item]
        }
    }
}

