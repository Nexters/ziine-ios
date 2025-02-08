//
//  DefaultTargetType.swift
//  Networking
//
//  Created by Geon Woo lee on 2/3/25.
//

import Moya

public enum DefaultTargetType {
    /// 아트워크 조회
    case fetchArtworks(page: Int)
}

extension DefaultTargetType: TargetType {
    public var baseURL: URL {
        guard let baseUrlString = Bundle.current.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("BASE_URL not found in Info.plist")
        }
        guard let url = URL(string: baseUrlString) else {
            fatalError("URL 타입 변환 실패")
        }
        return url
    }

    public var path: String {
        switch self {
        case let .fetchArtworks(page):
            return "/v1/artworks"
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

// FIXME: Bundle
extension Bundle {
    static var current: Bundle {
        class __ { }
        return Bundle(for: __.self)
    }
}
