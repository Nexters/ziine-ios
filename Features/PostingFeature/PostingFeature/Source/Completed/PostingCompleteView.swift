//
//  PostingCompleteView.swift
//  PostingFeature
//
//  Created by 이건우 on 2/15/25.
//

import SwiftUI
import CommonUI
import DesignSystem

struct LottieViewRepresentable: UIViewRepresentable {
    let assetName: String
    let width: CGFloat
    let height: CGFloat

    func makeUIView(context: Context) -> ZiineLottieView {
        let lottieView = ZiineLottieView(assetName: assetName, loopMode: .playOnce, width: width, height: height)
        lottieView.play(completion: {})
        return lottieView
    }

    func updateUIView(_ uiView: ZiineLottieView, context: Context) {}
}

struct PostingCompleteView: View {
    var body: some View {
        VStack {
            Group {
                Text("작품 등록이 신청되었어요!")
                    .font(Font(ZiineFont.h4))
                    .padding(.top, 32)
                    .padding(.bottom, 12)
                
                Text("최대 3일 내로 심사 후, 통과 시 자동으로 업로드됩니다.")
                    .font(Font(ZiineFont.p3))
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(.white)
            
            Spacer()
            
            LottieViewRepresentable(
                assetName: "after_uploaded",
                width: 280,
                height: 280
            )
            .frame(width: 200, height: 200)
            
            Spacer()
            
            Button {
                // TODO: action.
            } label: {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(style: .init(lineWidth: 1.5))
                    .foregroundStyle(ZiineColor.color(.p200))
                    .frame(height: 52)
                    .overlay {
                        Text("홈으로 이동하기")
                            .font(Font(ZiineFont.custom(weight: .semiBold, size: 16)))
                    }
                    .foregroundStyle(ZiineColor.color(.p500))
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 6)
        }
        .containerRelativeFrame(.horizontal)
        .background(ZiineColor.color(.g900))
    }
}

#Preview {
    PostingCompleteView()
}
