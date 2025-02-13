//
//  NetworkErrorUI.swift
//  CommonUI
//
//  Created by Geon Woo lee on 2/13/25.
//

import SwiftUI
import DesignSystem

public enum NetworkErrorUIListener {
    case retryButtonTapped
}

public struct NetworkErrorUI: View {
    public typealias Listener = ((NetworkErrorUIListener) -> ())
    
    private var listener: Listener?
    
    public init(listener: Listener?) {
        self.listener = listener
    }
    
    public var body: some View {
        VStack {
            Text("앗 오류가 발생했어요.")
                .font(Font(ZiineFont.s2))
                .padding(.bottom, 12)
                .padding(.top, 24)
                .foregroundStyle(ZiineColor.color(.g0))
            
            Text("다시 시도해주세요.")
                .font(Font(ZiineFont.s2))
                .padding(.bottom, 24)
                .foregroundStyle(ZiineColor.color(.g0))
            
            Spacer()
                .frame(height: 40)
            
            let screenWidth = UIScreen.main.bounds.width * 0.8
            Rectangle()
                .frame(
                    width: screenWidth,
                    height: screenWidth
                )
            
            Spacer()
                .frame(height: 40)
            
            Button {
                
            } label: {
                Text("다시 시도하기")
                    .foregroundStyle(ZiineColor.color(.g0))
                    .padding(.horizontal, 24.5)
                    .padding(.vertical, 12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(lineWidth: 1.5)
                            .foregroundStyle(
                                ZiineColor.color(.g700)
                            )
                    }
            }
            
            Spacer()
        }
        .containerRelativeFrame(.horizontal)
        .background(ZiineColor.color(.g900))
    }
}

#Preview {
    NetworkErrorUI(listener: nil)
}
