//
//  ArtworkRepository.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/3/25.
//

import Utils
import Combine
import Networking
import ArtworkFeatureInterface

final class DefaultArtworkRepository: ArtworkRepository {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetch(query: ArtworkRequestQuery.GetArtwork) async -> Result<[ArtworkModel], RepositoryError> {
        await withCheckedContinuation { continuation in
            self.apiClient.request(
                ResponseDTO.GetArtworkList.self,
                target: .fetchArtworks(page: query.page)
            ) { result in
                switch result {
                case .success(let success):
                    continuation.resume(returning: .success(success.toDomain()))
                case .failure(let error):
                    continuation.resume(returning: .failure(.message(error.localizedDescription)))
                }
            }
        }
    }
}
