//
//  CapsuleLabel.swift
//  CommonUI
//
//  Created by 이건우 on 2/11/25.
//

import UIKit

public final class CapsuleLabel: UILabel {
    
    private var edgeInsets: UIEdgeInsets = .init(top: 4.0, left: 10.0, bottom: 4.0, right: 10.0)
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }

    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        
        return CGSize(width: size.width + edgeInsets.left + edgeInsets.right,
                      height: size.height + edgeInsets.top + edgeInsets.bottom)
    }

    public override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (edgeInsets.left + edgeInsets.right)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }
}
