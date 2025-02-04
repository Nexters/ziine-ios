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
        var status: String
        var message: String
        
        func toDomain() -> [MagazineModel] {
            .init()
        }
    }
}
