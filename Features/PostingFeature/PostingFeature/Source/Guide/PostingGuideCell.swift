//
//  PostingGuideCell.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 2/15/25.
//

import SwiftUI
import DesignSystem

struct PostingGuideCell: View {
    private var guideMessage: PostingGuideMessage
    private var index: Int 
    
    init(
        index: Int,
        message: PostingGuideMessage
    ) {
        self.index = index
        self.guideMessage = message
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("0\(index)")
                .font(Font(ZiineFont.s1))
                .foregroundStyle(.white)
                .padding(.bottom, 4)
            
            Text(guideMessage.title)
                .font(Font(ZiineFont.s1))
                .padding(.bottom, 8)
                .foregroundStyle(.white)
            
            Text(guideMessage.description)
                .font(Font(ZiineFont.p3))
                .foregroundStyle(.white)
                .padding(.bottom, 14)
            
            ZiineImage.image(guideMessage.imageName)
                .resizable()
                .frame(height: 240)
                .cornerRadius(4)
                .padding(.horizontal, 11.5)
                .padding(.bottom, 24)
                .foregroundStyle(.white)
                
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        
    }
}
