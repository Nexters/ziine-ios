//
//  ZiineFont.swift
//  DesignSystem
//
//  Created by 이건우 on 1/26/25.
//

import UIKit
import SwiftUI

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
    static let h3 = ZiineFont.h3
    static let h4 = ZiineFont.h4
    static let h5 = ZiineFont.h5
    static let s1 = ZiineFont.s1
    static let s2 = ZiineFont.s2
    static let s3 = ZiineFont.s3
    static let p1 = ZiineFont.p1
    static let p2 = ZiineFont.p2
    static let p3 = ZiineFont.p3
    static let p4 = ZiineFont.p4
    static let p5 = ZiineFont.p5
    static let p6 = ZiineFont.p6
}

fileprivate struct FontPreviewView: View {
    private let sampleText = "Hello world!"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(FontStyle.allCases, id: \.self) { style in
                    VStack(alignment: .leading) {
                        Text(sampleText + style.rawValue)
                            .font(Font(uiFont: style.font))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 8)
                }
            }
            .padding()
        }
    }
}

extension Font {
    init(uiFont: UIFont) {
        self = Font.custom(uiFont.fontName, size: uiFont.pointSize)
    }
}

#Preview {
    FontPreviewView()
}
