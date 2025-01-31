//
//  ZiineImage.swift
//  DesignSystem
//
//  Created by 이건우 on 1/31/25.
//

import UIKit
import SwiftUI

public struct ZiineImage {
    public enum ImageName: String {
        // General Icons
        case arrowDown = "arrow_down"
        case arrowLeft = "arrow_left"
        case arrowRight = "arrow_right"
        case arrowUp = "arrow_up"
        case cancel = "cancel"
        case check = "check"
        case directionDown = "direction_down"
        case directionLeft = "direction_left"
        case directionRight = "direction_right"
        case directionUp = "direction_up"
        case dropDownArrow = "drop_down_arrow"
        case help = "help"
        case homeArtwork = "home_artwork"
        case home = "home"
        case iconoirBook = "iconoir_book"
        case link = "link"
        case magazine = "magazine"
        case plus = "plus"
        case settings = "settings"
        case share = "share"
        case upload = "upload"
        
        // Colorable Icons
        case instagramGray = "instagram_gray"
        case instagramPrimary = "instagram_primary"
    }
    
    /// UIKit에서 UIImage 반환
    public static func uiImage(_ name: ImageName) -> UIImage {
        return UIImage(named: name.rawValue, in: Bundle.current, with: nil) ?? UIImage()
    }
    
    /// SwiftUI에서 Image 반환
    public static func image(_ name: ImageName) -> Image {
        return Image(name.rawValue, bundle: Bundle.current)
    }
}

#Preview {
    HStack {
        Image(uiImage: ZiineImage.uiImage(.instagramPrimary))
        
        Image(uiImage: ZiineImage.uiImage(.arrowRight))
            .foregroundStyle(.red)
        
        Image(uiImage: ZiineImage.uiImage(.homeArtwork))
            .foregroundStyle(.g700)
    }
}
