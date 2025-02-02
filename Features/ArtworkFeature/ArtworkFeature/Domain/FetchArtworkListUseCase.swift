//
//  FetchArtworkListUseCase.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 2/3/25.
//

import Utils
import ArtworkFeatureInterface

final actor FetchArtworkListUseCase {
    
    private let artworkRepository: ArtworkRepository
    
    init(artworkRepository: ArtworkRepository) {
        self.artworkRepository = artworkRepository
        
        self.page = 1
    }
    
    private var page: Int
    
    func fetch() async -> Result<ArtworkModel, RepositoryError> {
        let result = await artworkRepository.fetch(query: .init(page: page))
        switch result {
        case .success(let success):
            return .success(success)
        case .failure(let message):
            return .failure(message)
        }
    }
    
    func pagination() async -> Result<ArtworkModel, RepositoryError> {
        page += 1
        return await fetch()
    }
}

//protocol DeleteProfileUseCase {
//    func execute(requestId: String) -> AnyPublisher<String, RepositoryError>
//}
//
//final class DefaultDeleteProfileUseCase: DeleteProfileUseCase {
//    
//    private let profileRepository: ProfileRepository
//    
//    init(profileRepository: ProfileRepository) {
//        self.profileRepository = profileRepository
//    }
//    
//    func execute(requestId: String) -> AnyPublisher<String, RepositoryError> {
//        let query = DeleteProfileQuery(profileId: requestId)
//        return profileRepository.deleteProfile(query: query)
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//}
