//
//  UILabel+.swift
//  DesignSystem
//
//  Created by 이건우 on 2/8/25.
//

import UIKit

extension UILabel {
    func setTextWithLineHeight(text: String?, font: FontStyle) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = font.lineHeight
            style.minimumLineHeight = font.lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (font.lineHeight - font.lineHeight) / 4,
                .font: font.font
            ]
            
            let attrString = NSAttributedString(string: text, attributes: attributes)
            self.attributedText = attrString
        }
    }
}
