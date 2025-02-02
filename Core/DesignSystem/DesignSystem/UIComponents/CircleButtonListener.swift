//
//  CircleButtonListener.swift
//  DesignSystem
//
//  Created by Geon Woo lee on 2/2/25.
//

import SwiftUI

public enum CircleButtonListener {
    case buttonTapped
}

public struct CircleButton: View {
    public typealias Listener = ((CircleButtonListener) -> ())
    
    private var listener: Listener?
    private var imageName: String
    
    public init(
        imageName: String,
        listener: Listener?
    ) {
        self.imageName = imageName
        self.listener = listener
    }
    
    public var body: some View {
        Button {
            listener?(.buttonTapped)
        } label: {
            Circle()
                .frame(width: 48, height: 48)
                .foregroundStyle(ZiineColor.color(.p500))
                .overlay {
                    Image(systemName: "plus")
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
        }
        
    }
}

#Preview {
    CircleButton(imageName: ZiineImage.ImageName.plus.rawValue, listener: nil)
}
