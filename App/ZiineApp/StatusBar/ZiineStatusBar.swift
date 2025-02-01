//
//  ZiineStatusBar.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 2/1/25.
//

import SwiftUI
import DesignSystem

struct ZiineStatusBar: View {
    @State private var selectedTab: Tab = .artworks
    @Namespace private var animationNamespace

    enum Tab: CaseIterable {
        case artworks, magazine
        
        var labelValue: String {
            switch self {
            case .artworks:
                return "Artworks"
            case .magazine:
                return "Magazine"
            }
        }
        
        
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                } label: {
                    Text(tab.labelValue)
                        .font(Font(ZiineFont.s2))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            ZStack {
                                if selectedTab == tab {
                                    Capsule()
                                        .fill(ZiineColor.color(.p500))
                                        .matchedGeometryEffect(id: "slider", in: animationNamespace)
                                }
                            }
                        )
                        .foregroundColor(
                            selectedTab == tab
                            ? ZiineColor.color(.g900)
                            : ZiineColor.color(.g600)
                        )
                }
            }
        }
        .frame(height: 40)
    }
}

#Preview {
    ZiineStatusBar()
}
