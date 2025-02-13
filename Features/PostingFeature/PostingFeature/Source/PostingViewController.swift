//
//  PostingViewController.swift
//  PostingFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import SwiftUI
import ThirdParty
import DesignSystem
internal import SnapKit
import PostingFeatureInterface

protocol PostingViewPresentableListener: AnyObject {
    func uploadButtonTapped()
}

final class PostingViewController: UIViewController,
                                   PostingViewPresentable,
                                   UICollectionViewDelegate
{
    var listener: PostingViewPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
    private let postingGuideView: UIView = {
        let hostingController = UIHostingController(
            rootView: PostingGuideView()
        )
        hostingController.view.backgroundColor = .clear
        return hostingController.view
    }()
    
    private func configureUI() {
        view.backgroundColor = ZiineColor.uiColor(.g900)
        
        view.addSubview(postingGuideView)
        postingGuideView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

fileprivate struct PostingGuideView: View {
    let guideMessage: [PostingGuideMessage] = PostingGuideMessage.make()
    
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
                PostingGuideCell(index: index + 1, message: message)
            }
        }
        .containerRelativeFrame(.horizontal)
        .background(ZiineColor.color(.g900))
    }
}

fileprivate struct PostingGuideCell: View {
    private var guideMessage: PostingGuideMessage
    private var index: Int
    
    init(index: Int, message: PostingGuideMessage) {
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
            
            Image(systemName: "chevron.right")
                .resizable()
                .frame(height: 240)
                .padding(.horizontal, 11.5)
                .padding(.bottom, 24)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
}

#Preview {
    PostingGuideView()
}
