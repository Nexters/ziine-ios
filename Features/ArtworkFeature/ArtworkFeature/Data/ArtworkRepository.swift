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

final class ArtworkRepository {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetch(query: ArtworkRequestQuery.GetArtwork) -> AnyPublisher<ArtworkModel, RepositoryError> {
        return Future { promise in
            self.apiClient.request(
                ResponseDTO.GetArtworkList.self,
                target: .fetchArtworks(page: query.page)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(let error):
                    promise(.failure(.message(error.localizedDescription)))
                }
            }
        }.eraseToAnyPublisher()
    }
}
