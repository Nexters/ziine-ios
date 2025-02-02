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
import ListKit

protocol ArtworkViewPresentableListener: AnyObject {
    func itemSelected(indexPath: IndexPath)
    func circleButtonTapped(action: CircleButtonListener)
}

final class ArtworkViewController: UIViewController {
    
    var listener: ArtworkViewPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIComponents
    
    private var collectionUI: CollectionUI = {
        let cv = CollectionUI()
        return cv
    }()
    
    private lazy var addCircleButton: UIView = {
        let circleButton = CircleButton(imageName: ZiineImage.ImageName.plus.rawValue) { [weak self] action in
            self?.listener?.circleButtonTapped(action: action)
        }
        let hostingController = UIHostingController(rootView: circleButton)
        hostingController.view.backgroundColor = .clear
        return hostingController.view!
    }()
    
    private func configureUI() {
        view.addSubview(collectionUI)
        collectionUI.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(addCircleButton)
        addCircleButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(16)
        }
    }
}

extension ArtworkViewController: ArtworkViewPresentable {
    func reloadCollectionUI(artworkModels: [ArtworkFeatureInterface.ArtworkModel]) {
        print(#function)
    }
    
    
}
