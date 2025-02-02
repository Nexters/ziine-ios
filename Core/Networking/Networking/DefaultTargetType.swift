//
//  DefaultTargetType.swift
//  Networking
//
//  Created by Geon Woo lee on 2/3/25.
//

public import Moya

public enum DefaultTargetType {
    /// 아트워크 조회
    case fetchArtworks(page: Int)
}

extension DefaultTargetType: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: "xcconfig") else {
            fatalError("URL 타입 변환 실패")
        }
        return url
    }

    public var path: String {
        switch self {
        case let .fetchArtworks(page):
            return "/v1/artwork/\(page)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchArtworks:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .fetchArtworks:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
        ]
    }
}
