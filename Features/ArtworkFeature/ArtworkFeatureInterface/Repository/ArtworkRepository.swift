//
//  ArtworkRepository.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/3/25.
//

import Utils

public protocol ArtworkRepository {
    func fetch(query: ArtworkRequestQuery.GetArtwork) async -> Result<ArtworkModel, RepositoryError>
}
