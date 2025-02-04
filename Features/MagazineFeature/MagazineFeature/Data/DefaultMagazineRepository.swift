//
//  DefaultMagazineRepository.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/4/25.
//

import Utils
import Combine
import Networking
import MagazineFeatureInterface

final class DefaultMagazineRepository: MagazineRepository {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetch(query: MagazineRequestQuery.GetMagazine) async -> Result<[MagazineModel], RepositoryError> {
        await withCheckedContinuation { continuation in
            self.apiClient.request(
                ResponseDTO.GetMagazineList.self,
                target: .fetchMagazines
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
