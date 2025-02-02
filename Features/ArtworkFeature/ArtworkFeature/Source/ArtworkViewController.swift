//
//  ArtworkViewController.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import SwiftUI
import ArtworkFeatureInterface
import DesignSystem
internal import SnapKit

protocol ArtworkViewPresentableListener: AnyObject {
    func itemSelected(indexPath: IndexPath)
    func circleButtonTapped(action: CircleButtonListener)
}

final class ArtworkViewController: UIViewController,
                                   ArtworkViewPresentable,
                                   UICollectionViewDelegate
{
    var listener: ArtworkViewPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
//    private let collectionView = UICollectionView()
    
    private lazy var addCircleButton: UIView = {
        let circleButton = CircleButton(imageName: ZiineImage.ImageName.plus.rawValue) { [weak self] action in
            self?.listener?.circleButtonTapped(action: action)
        }
        let hostingController = UIHostingController(rootView: circleButton)
        hostingController.view.backgroundColor = .clear
        return hostingController.view!
    }()
    
    private func configureUI() {
        view.addSubview(addCircleButton)
        addCircleButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16)
        }
    }
    
    // TODO: - 컬렉션 UI 도입해서 분리할 예정
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        listener?.itemSelected(indexPath: indexPath)
//    }
}
