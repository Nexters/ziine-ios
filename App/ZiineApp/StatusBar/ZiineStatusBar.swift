//
//  ZiineStatusBar.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 2/1/25.
//

import SwiftUI
import DesignSystem

enum ZiineStatusBarListener {
    case onChange(newValue: ZiinStatusTabBarItem)
}

enum ZiinStatusTabBarItem: Hashable, CaseIterable {
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

struct ZiineStatusBar: View {
    @State private var selectedTab: ZiinStatusTabBarItem = .artworks
    @Namespace private var animationNamespace

    private var listener: ((ZiineStatusBarListener) -> ())?
    
    init(listener: ((ZiineStatusBarListener) -> ())?) {
        self.listener = listener
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(ZiinStatusTabBarItem.allCases, id: \.self) { tab in
                Button {
                    if selectedTab != tab {
                        listener?(.onChange(newValue: tab))
                        
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            selectedTab = tab
                        }
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
            .padding(.bottom, 20)
        }
        .containerRelativeFrame(.horizontal)
        .background(ZiineColor.color(.g900))
    }
}

#Preview {
    ZiineStatusBar(listener: nil)
}
