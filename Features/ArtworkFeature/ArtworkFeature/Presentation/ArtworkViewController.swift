//
//  ArtworkViewController.swift
//  ArtworkFeature
//
//  Created by Geon Woo lee on 1/28/25.
//

import UIKit
import SwiftUI
import ListKit
import CommonUI
import DesignSystem
internal import SnapKit
import ArtworkFeatureInterface

protocol ArtworkViewPresentableListener: AnyObject {
    func modelSelected(dataModel: ListDataModel)
    func circleButton(action: CircleButtonListener)
    func didBecomeActive()
    func networkError(action: NetworkErrorUIListener)
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
    
    private lazy var collectionUI: CollectionUI = {
        let cv = CollectionUI(listener: nil)
        return cv
    }()
    
    private lazy var addCircleButton: UIView = {
        let circleButton = CircleButton(imageName: ZiineImage.ImageName.plus.rawValue) { [weak self] action in
            self?.listener?.circleButton(action: action)
        }
        let hostingController = UIHostingController(rootView: circleButton)
        hostingController.view.backgroundColor = .clear
        return hostingController.view
    }()
    
    private lazy var networkErrorUI: UIView = {
        let ui = NetworkErrorUI { [weak self] action in
            self?.listener?.networkError(action: action)
        }
        let hostingController = UIHostingController(rootView: ui)
        hostingController.view.backgroundColor = .clear
        hostingController.view.isHidden = true
        return hostingController.view
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
        
        view.addSubview(networkErrorUI)
        networkErrorUI.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ArtworkViewController: ArtworkViewPresentable {
    func showsNetworkErrorUI() {
        networkErrorUI.isHidden = false
        collectionUI.isHidden = true
    }
    
    func reloadCollectionUI(artworkModels: [ArtworkFeatureInterface.ArtworkModel]) {
        if artworkModels.isEmpty {
            showsNetworkErrorUI()
        } else {
            networkErrorUI.isHidden = true
            collectionUI.isHidden = false
        }
        
        var uiModels: [ListDataModel] = []
        let builder = ArtworkCellUIBuilder()
        var sectionItems: [CollectionUISectionItem] = []
        
        // TODO: - 로직간소화
        
        artworkModels.forEach { artworkModel in
            var uiModel = ListDataModel()
            uiModel.profileImageUrlString = artworkModel.artist.profileImageUrl
            uiModel.thumbnailImageUrlString = artworkModel.artworkImageUrl
            uiModel.title = artworkModel.title
            uiModel.username = artworkModel.artist.name
            
            uiModels.append(uiModel)
        }
        
        uiModels.forEach { dataModel in
            builder.configure(dataModel: dataModel, listener: self)
            
            sectionItems.append(.artworkThumbnail(builder))
        }
        
        var sections: [CollectionUISection] = []
        sections.append(.default(sectionItems))

        collectionUI.configure(
            sections: sections
        )
    }
    
}

extension ArtworkViewController: ArtworkCellUIBuilder.Listener {
    func modelSelected(dataModel: ListDataModel) {
        listener?.modelSelected(dataModel: dataModel)
    }
}
