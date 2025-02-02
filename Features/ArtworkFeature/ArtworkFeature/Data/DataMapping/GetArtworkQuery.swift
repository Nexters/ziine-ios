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
        var status: String
        var message: String
        
        func toDomain() -> ArtworkModel {
            .init()
        }
    }
}
