//
//  FetchArtworkListUseCase.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/3/25.
//

import Utils
import ArtworkFeatureInterface

public final actor DefaultFetchArtworkListUseCase: FetchArtworkListUseCase {
    public typealias ResultType = Result<[ArtworkModel], RepositoryError>
    
    private let artworkRepository: ArtworkRepository
    
    public init(artworkRepository: ArtworkRepository) {
        self.artworkRepository = artworkRepository
    }
    
    public func fetch() async -> ResultType {
        return await execute()
    }
    
    public func pagination() async -> ResultType {
        return await execute()
    }
    
    private func execute() async -> ResultType {
        let result = await artworkRepository.fetch()
        switch result {
        case .success(let success):
            return .success(success)
        case .failure(let message):
            return .failure(message)
        }
    }
}
