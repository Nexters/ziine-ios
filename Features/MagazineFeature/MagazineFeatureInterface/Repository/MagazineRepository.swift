//
//  MagazineRepository.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/4/25.
//

import Utils

public protocol MagazineRepository {
    func fetch() async -> Result<[MagazineModel], RepositoryError>
}
