//
//  FontStyle.swift
//  DesignSystem
//
//  Created by 이건우 on 1/26/25.
//

import UIKit

/// 앱 내부에서 사용되는 Pretendard font weight
public enum FontWeight: String {
    case regular = "Regular"
    case medium = "Medium"
    case semiBold = "SemiBold"
}

/// Figma의 Font System 기반 스타일 정의
public enum FontStyle {
    case h3, h4, h5
    case s1, s2, s3
    case p1, p2, p3, p4, p5, p6
    
    var size: CGFloat {
        switch self {
        case .h3: return 28
        case .h4: return 24
        case .h5: return 20
        case .s1: return 18
        case .s2, .p1: return 16
        case .s3, .p2: return 14
        case .p3: return 13
        case .p4: return 12
        case .p5, .p6: return 11
        }
    }
    
    var weight: FontWeight {
        switch self {
        case .h3, .h4, .h5, .s1, .s2, .s3:
            return .semiBold
        case .p1, .p2, .p3, .p4:
            return .medium
        case .p5, .p6:
            return .regular
        }
    }
    
    var font: UIFont {
        return ZiineFont.custom(weight: weight, size: size)
    }
}
