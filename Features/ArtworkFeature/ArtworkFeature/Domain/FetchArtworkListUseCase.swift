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
        
        self.page = 1
    }
    
    private var page: Int
    
    public func fetch() async -> ResultType {
        page = 1
        return await execute(page: page)
    }
    
    public func pagination() async -> ResultType {
        page += 1
        return await execute(page: page)
    }
    
    private func execute(page: Int) async -> ResultType {
        let result = await artworkRepository.fetch(query: .init(page: page))
        switch result {
        case .success(let success):
            return .success(success)
        case .failure(let message):
            return .failure(message)
        }
    }
}
