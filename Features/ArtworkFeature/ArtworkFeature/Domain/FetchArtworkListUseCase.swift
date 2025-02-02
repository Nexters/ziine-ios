//
//  FetchArtworkListUseCase.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/3/25.
//

import Utils
import ArtworkFeatureInterface

public protocol FetchArtworkListUseCase {
    func fetch() async -> Result<ArtworkModel, RepositoryError>
    func pagination() async -> Result<ArtworkModel, RepositoryError>
}

final actor DefaultFetchArtworkListUseCase: FetchArtworkListUseCase {
    
    private let artworkRepository: ArtworkRepository
    
    init(artworkRepository: ArtworkRepository) {
        self.artworkRepository = artworkRepository
        
        self.page = 1
    }
    
    private var page: Int
    
    func fetch() async -> Result<ArtworkModel, RepositoryError> {
        page = 1
        return await execute(page: page)
    }
    
    func pagination() async -> Result<ArtworkModel, RepositoryError> {
        page += 1
        return await fetch()
    }
    
    private func execute(page: Int) async -> Result<ArtworkModel, RepositoryError> {
        let result = await artworkRepository.fetch(query: .init(page: page))
        switch result {
        case .success(let success):
            return .success(success)
        case .failure(let message):
            return .failure(message)
        }
    }
}
