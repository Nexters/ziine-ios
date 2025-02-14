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
    func postingGuideView(listener: PostingGuideViewListener)
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
    
    private lazy var postingGuideView: UIView = {
        let swiftUIView = PostingGuideView { [weak self] action in
            self?.listener?.postingGuideView(listener: action)
        }
        let hostingController = UIHostingController(
            rootView: swiftUIView
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

// MARK: - PostingGuideView

public enum PostingGuideViewListener {
    case postingButtonTapped
}

fileprivate struct PostingGuideView: View {
    public typealias Listener = ((PostingGuideViewListener) -> ())
    
    private var listener: Listener?
    
    public init(listener: Listener?) {
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
                PostingGuideCell(index: index + 1, message: message)
            }
            .padding(.bottom, bottomButtonHeight)
        }
        .containerRelativeFrame(.horizontal)
        .background(ZiineColor.color(.g900))
        .overlay(alignment: .bottom) {
            Button {
                listener?(.postingButtonTapped)
            } label: {
                RoundedRectangle(cornerRadius: 16)
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
            
            ZiineImage.image(guideMessage.imageName)
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
    PostingGuideView(listener: nil)
}
