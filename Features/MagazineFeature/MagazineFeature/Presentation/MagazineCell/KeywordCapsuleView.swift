//
//  MagazineCellView.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/7/25.
//

import SwiftUI
import DesignSystem
import MagazineFeatureInterface

struct KeywordCapsuleView: View {
    var keywords: [String]
    
    init(keywords: [String]) {
        self.keywords = keywords
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(keywords, id: \.self) { keyword in
                Text("#\(keyword)")
                    .fontWithLineHeight(.p4)
                    .foregroundStyle(ZiineColor.color(.g900))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(
                        Capsule(style: .continuous)
                            .stroke(ZiineColor.color(.g900), lineWidth: 1.5)
                    )
            }
            
            Spacer()
        }
    }
}

#Preview {
    KeywordCapsuleView(keywords: .init(repeating: "키워드", count: 3))
}
