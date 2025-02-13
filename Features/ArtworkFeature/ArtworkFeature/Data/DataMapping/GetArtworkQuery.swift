//
//  GetArtworkQuery.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/3/25.
//

import Networking
import ArtworkFeatureInterface

extension ResponseDTO {
    struct GetArtworkList: Respondable {
        var artworks: [Artwork]
        
        struct Artwork: Decodable {
            var id: Int
            var title: String
            var artworkImageUrl: String
            var createdAt: String
            var modifiedAt: String
            var artist: Artist
            
            struct Artist: Decodable {
                var id: Int
                var name: String
                var profileImageUrl: String
            }
        }
        
        func toDomain() -> [ArtworkModel] {
            
            
            artworks.map { artwork in
                ArtworkModel(
                    id: artwork.id,
                    title: artwork.title,
                    artworkImageUrl: artwork.artworkImageUrl,
                    createdAt: artwork.createdAt,
                    modifiedAt: artwork.modifiedAt,
                    artist: ArtworkModel.Artist(
                        id: artwork.artist.id,
                        name: artwork.artist.name,
                        profileImageUrl: artwork.artist.profileImageUrl
                    )
                )
            }
        }
    }
}
