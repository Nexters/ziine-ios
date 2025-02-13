//
//  FetchMagazineListUseCase.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/4/25.
//

import Utils

public protocol FetchMagazineListUseCase {
    func fetch() async -> Result<[MagazineModel], RepositoryError>
}
