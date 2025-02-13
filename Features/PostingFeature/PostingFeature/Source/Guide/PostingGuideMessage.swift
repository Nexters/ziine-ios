//
//  PostingGuideMessage.swift
//  PostingFeature
//
//  Created by 이건우 on 2/13/25.
//

struct PostingGuideMessage: Hashable {
    let title: String
    let description: String
}

extension PostingGuideMessage {
    static func make() -> [PostingGuideMessage] {
        return [
            .init(
                title: "깔끔한 배경에서 촬영 또는 보정 및 크롭하여 업로드 해주세요.",
                description: "배경이 많이 보이거 빛 반사가 된 이미지와 같은 경우, 작품 심사가 반려될 수 있어요."
            ),
            .init(
                title: "작품 승인 후 등록이 가능해요.",
                description: "작가가 작품 등록 요청 후, Ziine 측에서 등록 여부를 심사 후 등록돼요. 작품 등록 화면에서 메일을 작성하면 심사 통과 여부를 메일로 받아볼 수 있어요."
            ),
            .init(
                title: "승인까지의 시간은 최대 3일 소요 예정이에요.",
                description: "심사 통과 시, 별도의 추가 등록 과정 없이 자동으로 업로드 돼요."
            )
        ]
    }
}
