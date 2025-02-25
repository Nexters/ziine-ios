//
//  MagazineModel.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/4/25.
//

import Foundation

public struct MagazineModel {
    public let id: Int
    public let title: String
    public let summary: String
    public let thumbnailImageURL: String
    public let keywords: [String]
    public let backgroundColor: String
    public let createdAt: String
    public let modifiedAt: String
    
    public init(
        id: Int,
        title: String,
        summary: String,
        thumbnailImageURL: String,
        keywords: [String],
        backgroundColor: String,
        createdAt: String,
        modifiedAt: String
    ) {
        self.id = id
        self.title = title
        self.summary = summary
        self.thumbnailImageURL = thumbnailImageURL
        self.keywords = keywords
        self.backgroundColor = backgroundColor
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
}
