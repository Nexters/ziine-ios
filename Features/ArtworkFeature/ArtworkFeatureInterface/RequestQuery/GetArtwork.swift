//
//  GetArtwork.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/3/25.
//

extension ArtworkRequestQuery {
    public struct GetArtwork {
        public var page: Int
        
        public init(page: Int) {
            self.page = page
        }
    }
}
