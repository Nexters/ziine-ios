//
//  UILabel+.swift
//  DesignSystem
//
//  Created by 이건우 on 2/8/25.
//

import UIKit

public extension UILabel {
    func setTextWithLineHeight(text: String?, fontStyle: FontStyle) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = fontStyle.lineHeight
            style.minimumLineHeight = fontStyle.lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (fontStyle.lineHeight - fontStyle.font.lineHeight) / 2,
                .font: fontStyle.font
            ]
            
            let attrString = NSAttributedString(string: text, attributes: attributes)
            self.attributedText = attrString
        }
    }
    
    func showBorder(
        color: CGColor = UIColor.red.cgColor,
        borderWidth: CGFloat = 1
    ) {
        self.layer.borderColor = color
        self.layer.borderWidth = 1
    }
}
