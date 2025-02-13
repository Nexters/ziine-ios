//
//  APIClient.swift
//  Networking
//
//  Created by Geon Woo lee on 2/3/25.
//

import Foundation
public import Moya

public final class APIClient {
    private let provider: MoyaProvider<DefaultTargetType>

    public init() {
        provider = MoyaProvider<DefaultTargetType>()
    }
    
    /// response가 있는 api request에 사용
    public func request<T: Respondable>(
        _ T: T.Type,
        target: DefaultTargetType,
        completion: @escaping (Result<T, MoyaError>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                guard (200..<300) ~= response.statusCode else {
                    completion(.failure(.statusCode(response)))
                    return
                }
                
                do {
                    let data = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(data))
                } catch let error {
                    print("🐛 decoding Erorr: \(error)")
                    completion(.failure(.objectMapping(error, response)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
