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

public extension UIColor {
    static let primary100 = ZiineColor.uiColor(.p100)
    static let primary150 = ZiineColor.uiColor(.p150)
    static let primary200 = ZiineColor.uiColor(.p200)
    static let primary300 = ZiineColor.uiColor(.p300)
    static let primary400 = ZiineColor.uiColor(.p400)
    static let primary500 = ZiineColor.uiColor(.p500)
    static let primary600 = ZiineColor.uiColor(.p600)
    static let primary700 = ZiineColor.uiColor(.p700)
    static let primary800 = ZiineColor.uiColor(.p800)
    static let primary900 = ZiineColor.uiColor(.p900)

    static let gray0 = ZiineColor.uiColor(.g0)
    static let gray50 = ZiineColor.uiColor(.g50)
    static let gray100 = ZiineColor.uiColor(.g100)
    static let gray200 = ZiineColor.uiColor(.g200)
    static let gray300 = ZiineColor.uiColor(.g300)
    static let gray400 = ZiineColor.uiColor(.g400)
    static let gray500 = ZiineColor.uiColor(.g500)
    static let gray600 = ZiineColor.uiColor(.g600)
    static let gray700 = ZiineColor.uiColor(.g700)
    static let gray800 = ZiineColor.uiColor(.g800)
    static let gray900 = ZiineColor.uiColor(.g900)
    static let black50 = ZiineColor.uiColor(.black50)

    static let success150 = ZiineColor.uiColor(.s150)
    static let success300 = ZiineColor.uiColor(.s300)
    static let success500 = ZiineColor.uiColor(.s500)
    static let success700 = ZiineColor.uiColor(.s700)

    static let error150 = ZiineColor.uiColor(.e150)
    static let error300 = ZiineColor.uiColor(.e300)
    static let error500 = ZiineColor.uiColor(.e500)
    static let error700 = ZiineColor.uiColor(.e700)
}

public extension Color {
    static let primary100 = ZiineColor.color(.p100)
    static let primary150 = ZiineColor.color(.p150)
    static let primary200 = ZiineColor.color(.p200)
    static let primary300 = ZiineColor.color(.p300)
    static let primary400 = ZiineColor.color(.p400)
    static let primary500 = ZiineColor.color(.p500)
    static let primary600 = ZiineColor.color(.p600)
    static let primary700 = ZiineColor.color(.p700)
    static let primary800 = ZiineColor.color(.p800)
    static let primary900 = ZiineColor.color(.p900)

    static let gray0 = ZiineColor.color(.g0)
    static let gray50 = ZiineColor.color(.g50)
    static let gray100 = ZiineColor.color(.g100)
    static let gray200 = ZiineColor.color(.g200)
    static let gray300 = ZiineColor.color(.g300)
    static let gray400 = ZiineColor.color(.g400)
    static let gray500 = ZiineColor.color(.g500)
    static let gray600 = ZiineColor.color(.g600)
    static let gray700 = ZiineColor.color(.g700)
    static let gray800 = ZiineColor.color(.g800)
    static let gray900 = ZiineColor.color(.g900)
    static let black50 = ZiineColor.color(.black50)

    static let success150 = ZiineColor.color(.s150)
    static let success300 = ZiineColor.color(.s300)
    static let success500 = ZiineColor.color(.s500)
    static let success700 = ZiineColor.color(.s700)

    static let error150 = ZiineColor.color(.e150)
    static let error300 = ZiineColor.color(.e300)
    static let error500 = ZiineColor.color(.e500)
    static let error700 = ZiineColor.color(.e700)
}
