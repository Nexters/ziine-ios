//
//  ArtworkModel.swift
//  ArtworkFeatureInterface
//
//  Created by Geon Woo lee on 2/3/25.
//

import Foundation

public struct ArtworkModel {
    public var id: Int
    public var title: String
    public var artworkImageUrl: String
    public var createdAt: String
    public var modifiedAt: String
    public var artist: Artist
    
    public struct Artist {
        public var id: Int
        public var name: String
        public var profileImageUrl: String
        
        public init(id: Int, name: String, profileImageUrl: String) {
            self.id = id
            self.name = name
            self.profileImageUrl = profileImageUrl
        }
    }
    
    public init(id: Int, title: String, artworkImageUrl: String, createdAt: String, modifiedAt: String, artist: Artist) {
        self.id = id
        self.title = title
        self.artworkImageUrl = artworkImageUrl
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
        self.artist = artist
    }
}
