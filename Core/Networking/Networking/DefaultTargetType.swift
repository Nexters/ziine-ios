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
    
    /// 매거진 조회
    case fetchMagazines
}

extension DefaultTargetType: TargetType {
    public var baseURL: URL {
        guard let baseUrlString = Bundle.current.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("BASE_URL not found in Info.plist")
//            return URL(string: "https://www.naver.com")!
        }
        guard let url = URL(string: baseUrlString) else {
            fatalError("URL 타입 변환 실패")
//            return URL(string: "https://www.naver.com")!
        }
        return url
    }

    public var path: String {
        switch self {
        case let .fetchArtworks(page):
            return "/v1/artworks"
        case .fetchMagazines:
            return "/v1/magazines"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchArtworks, .fetchMagazines:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .fetchArtworks, .fetchMagazines:
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
