//
//  ZiineFont.swift
//  DesignSystem
//
//  Created by 이건우 on 1/26/25.
//

import UIKit

public struct ZiineFont {
    /// FontStyle에서 벗어나는 Custom Font 대응
    public static func custom(weight: FontWeight, size: CGFloat) -> UIFont {
        UIFont(name: "Pretendard-\(weight.rawValue)", size: size) ??
        UIFont.systemFont(ofSize: size, weight: ZiineFont.mapToSystemWeight(weight))
    }
    
    /// 시스템 폰트 weight 매핑
    private static func mapToSystemWeight(_ weight: FontWeight) -> UIFont.Weight {
        switch weight {
        case .regular: return .regular
        case .medium: return .medium
        case .semiBold: return .semibold
        }
    }
    
    /// 정적 프로퍼티를 이용한 폰트 접근
    public static let h3 = FontStyle.h3.font
    public static let h4 = FontStyle.h4.font
    public static let h5 = FontStyle.h5.font
    public static let s1 = FontStyle.s1.font
    public static let s2 = FontStyle.s2.font
    public static let s3 = FontStyle.s3.font
    public static let p1 = FontStyle.p1.font
    public static let p2 = FontStyle.p2.font
    public static let p3 = FontStyle.p3.font
    public static let p4 = FontStyle.p4.font
    public static let p5 = FontStyle.p5.font
    public static let p6 = FontStyle.p6.font
}

/// `UIFont.Ziine.h3` 같은 형태로 사용 가능하도록 확장
public extension UIFont {
    struct Ziine {
        public static let h3 = ZiineFont.h3
        public static let h4 = ZiineFont.h4
        public static let h5 = ZiineFont.h5
        public static let s1 = ZiineFont.s1
        public static let s2 = ZiineFont.s2
        public static let s3 = ZiineFont.s3
        public static let p1 = ZiineFont.p1
        public static let p2 = ZiineFont.p2
        public static let p3 = ZiineFont.p3
        public static let p4 = ZiineFont.p4
        public static let p5 = ZiineFont.p5
        public static let p6 = ZiineFont.p6
    }
}
