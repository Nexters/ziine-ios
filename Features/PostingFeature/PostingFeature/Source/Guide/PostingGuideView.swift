//
//  PostingGuideViewListener.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 2/15/25.
//

import SwiftUI
import DesignSystem

enum PostingGuideViewListener {
    case postingButtonTapped
}

struct PostingGuideView: View {
    public typealias Listener = ((PostingGuideViewListener) -> ())
    
    var listener: Listener?
    
    init(listener: Listener?) {
        self.listener = listener
    }
    
    private let guideMessage: [PostingGuideMessage] = PostingGuideMessage.make()
    private let bottomButtonHeight: CGFloat = 52
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12) {
                Text("작가님의 작품을 등록하기 전,")
                Text("꼭 확인해주세요!")
            }
            .font(Font(ZiineFont.h4))
            .foregroundStyle(.white)
            .padding(.vertical, 40)
            
            ForEach(Array(guideMessage.enumerated()), id: \ .offset) { index, message in
                PostingGuideCell(
                    index: index + 1,
                    message: message
                )
            }
            .padding(.bottom, bottomButtonHeight)
        }
        .containerRelativeFrame(.horizontal)
        .background(ZiineColor.color(.g900))
        .overlay(alignment: .bottom) {
            Button {
                listener?(.postingButtonTapped)
            } label: {
                RoundedRectangle(cornerRadius: 6)
                    .frame(height: bottomButtonHeight)
                    .padding(.horizontal, 16)
                    .foregroundStyle(ZiineColor.color(.p500))
                    .overlay {
                        Text("작품 등록하기")
                            .font(Font(ZiineFont.custom(weight: .semiBold, size: 16)))
                            .foregroundStyle(ZiineColor.color(.g900))
                    }
            }
            .padding(.top, 12)
            .background(ZiineColor.color(.g900))
        }
    }
}

#Preview {
    PostingGuideView(listener: nil)
}
