//
//  FetchMagazineListUseCase.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/4/25.
//

import Utils
import MagazineFeatureInterface

public final actor DefaultFetchMagazineListUseCase: FetchMagazineListUseCase {
    public typealias ResultType = Result<[MagazineModel], RepositoryError>
    
    private let magazineRepository: MagazineRepository
    
    public init(magazineRepository: MagazineRepository) {
        self.magazineRepository = magazineRepository
    }
    
    public func fetch() async -> ResultType {
        return await execute()
    }
    
    private func execute() async -> ResultType {
        let result = await magazineRepository.fetch()
        switch result {
        case .success(let success):
            return .success(success)
        case .failure(let message):
            return .failure(message)
        }
    }
}
