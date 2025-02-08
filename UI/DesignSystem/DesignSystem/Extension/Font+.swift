//
//  Font+.swift
//  DesignSystem
//
//  Created by 이건우 on 2/8/25.
//

import SwiftUI

struct FontWithLineHeight: ViewModifier {
    let fontStyle: FontStyle
    private var lineHeight: CGFloat { fontStyle.lineHeight }

    func body(content: Content) -> some View {
        content
            .lineSpacing(lineHeight - fontStyle.size)
            .padding(.vertical, (lineHeight - fontStyle.size) / 2)
            .font(Font(fontStyle.font))
    }
}

extension View {
    func fontWithLineHeight(_ fontStyle: FontStyle) -> some View {
        self.modifier(FontWithLineHeight(fontStyle: fontStyle))
    }
}
