//
//  MagazineModel.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/4/25.
//

import Foundation

public struct MagazineModel {
    public let title: String
    public let summary: String
    public let thumbnailImageURL: String
    public let keywords: [String]
    public let createdAt: String
    public let modifiedAt: String
    
    public init(
        title: String,
        summary: String,
        thumbnailImageURL: String,
        keywords: [String],
        createdAt: String,
        modifiedAt: String
    ) {
        self.title = title
        self.summary = summary
        self.thumbnailImageURL = thumbnailImageURL
        self.keywords = keywords
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
}
