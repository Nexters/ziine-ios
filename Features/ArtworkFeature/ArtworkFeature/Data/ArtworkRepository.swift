//
//  ArtworkRepository.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/3/25.
//

import Combine
import Networking
import ArtworkFeatureInterface

final class ArtworkRepository {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetch(query: ArtworkRequestQuery.GetArtwork) -> AnyPublisher<ArtworkModel, Error> {
        return Future { promise in
            self.apiClient.request(
                ResponseDTO.GetArtworkList.self,
                target: .fetchArtworks(page: query.page)
            ) { result in
                switch result {
                case .success(let success):
                    promise(.success(success.toDomain()))
                case .failure(let error):
//                    promise(.failure(.message("프로필 정보 조회를 실패했어요.")))
                    break
                }
            }
        }.eraseToAnyPublisher()
    }
}
