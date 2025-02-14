//
//  GetMagazineQuery.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/4/25.
//

import Networking
import MagazineFeatureInterface

extension ResponseDTO {
    struct GetMagazineList: Respondable {
        var magazines: [Magazine]
        var totalCount: Int
        
        struct Magazine: Decodable {
            var id: Int
            var title: String
            var summary: String
            var thumbnailImageUrl: String
            var keywords: [String]
            var createdAt: String
            var modifiedAt: String
        }
        
        func toDomain() -> [MagazineModel] {
            return magazines.map {
                MagazineModel(
                    title: $0.title,
                    summary: $0.summary,
                    thumbnailImageURL: $0.thumbnailImageUrl,
                    keywords: $0.keywords,
                    createdAt: $0.createdAt,
                    modifiedAt: $0.modifiedAt
                )
            }
        }
    }
}
