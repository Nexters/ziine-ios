//
//  UILabel+.swift
//  DesignSystem
//
//  Created by 이건우 on 2/8/25.
//

import UIKit

extension UILabel {
    func setTextWithLineHeight(text: String?, fontStyle: FontStyle) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = fontStyle.lineHeight
            style.minimumLineHeight = fontStyle.lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (fontStyle.lineHeight - fontStyle.lineHeight) / 4,
                .font: fontStyle.font
            ]
            
            let attrString = NSAttributedString(string: text, attributes: attributes)
            self.attributedText = attrString
        }
    }
}
