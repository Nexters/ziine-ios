//
//  ListDataModel.swift
//  ListKit
//
//  Created by Geon Woo lee on 2/8/25.
//

import Foundation

public struct ListDataModel {
    
    /// 아트워크 id
    public var id: Int?
    
    /// 타이틀
    public var title: String?
    
    /// 유저이름
    public var username: String?
    
    /// 프로필 이미지
    public var profileImageUrlString: String?
    
    /// 썸네일 이미지
    public var thumbnailImageUrlString: String?
    
    public init(
        id: Int? = nil,
        title: String? = nil,
        username: String? = nil,
        profileImageUrlString: String? = nil,
        thumbnailImageUrlString: String? = nil
    ) {
        self.id = id
        self.title = title
        self.username = username
        self.profileImageUrlString = profileImageUrlString
        self.thumbnailImageUrlString = thumbnailImageUrlString
    }
}
