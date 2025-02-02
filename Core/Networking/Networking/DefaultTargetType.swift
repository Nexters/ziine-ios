//
//  DefaultTargetType.swift
//  Networking
//
//  Created by Geon Woo lee on 2/3/25.
//

internal import Moya

enum DefaultTargetType {
    /// 아트워크 조회
    case fetchArtworks(page: Int)
}

extension DefaultTargetType: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "xcconfig") else {
            fatalError("URL 타입 변환 실패")
        }
        return url
    }

    var path: String {
        switch self {
        case let .fetchArtworks(page):
            return "/v1/artwork/\(page)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchArtworks:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .fetchArtworks:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
        ]
    }
}
