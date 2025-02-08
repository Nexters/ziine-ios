//
//  ArtworkModel.swift
//  ArtworkFeatureInterface
//
//  Created by Geon Woo lee on 2/3/25.
//

import Foundation

public struct ArtworkModel {
    public var title: String
    public var username: String
    public var profileImageUrlString: String
    public var thumbnailImageUrlString: String
    
    public init(
        title: String,
        username: String,
        profileImageUrlString: String,
        thumbnailImageUrlString: String
    ) {
        self.title = title
        self.username = username
        self.profileImageUrlString = profileImageUrlString
        self.thumbnailImageUrlString = thumbnailImageUrlString
    }
}
