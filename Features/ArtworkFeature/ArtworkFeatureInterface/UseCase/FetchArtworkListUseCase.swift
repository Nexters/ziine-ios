//
//  FetchArtworkListUseCase.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/3/25.
//

import Utils

public protocol FetchArtworkListUseCase {
    func execute() async -> Result<[ArtworkModel], RepositoryError>
}
