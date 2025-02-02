//
//  ZiineColor.swift
//  DesignSystem
//
//  Created by 이건우 on 1/27/25.
//

import UIKit
import SwiftUI

// FIXME: Bundle
extension Bundle {
    static var current: Bundle {
        class __ { }
        return Bundle(for: __.self)
    }
}

public struct ZiineColor {
    public enum ColorName: String {
        
        // MARK: Primary Color
        case p100
        case p150
        case p200
        case p300
        case p400
        case p500
        case p600
        case p700
        case p800
        case p900
        
        // MARK: Gray Scale
        case g0
        case g50
        case g100
        case g200
        case g300
        case g400
        case g500
        case g600
        case g700
        case g800
        case g900
        case black50 = "black-op50"
        
        // MARK: Feedback Color
        // Success Color
        case s150
        case s300
        case s500
        case s700
        
        // Error Color
        case e150
        case e300
        case e500
        case e700
    }
    
    /// for UiKit UIColor
    public static func uiColor(_ name: ColorName) -> UIColor {
        return UIColor(named: name.rawValue, in: Bundle.current, compatibleWith: nil) ?? .clear
    }
    
    /// for SwiftUI Color
    public static func color(_ name: ColorName) -> Color {
        return Color(name.rawValue, bundle: Bundle.current)
    }
}
