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
        updateUIVisibility(hasData: !artworkModels.isEmpty)
        
        let uiModels = convertToUIModels(from: artworkModels)
        let sectionItems = buildSectionItems(from: uiModels)
        
        let sections: [CollectionUISection] = [.default(sectionItems)]
        
        collectionUI.configure(sections: sections)
    }
    
    /// handle error ui
    private func updateUIVisibility(hasData: Bool) {
        networkErrorUI.isHidden = hasData
        collectionUI.isHidden = !hasData
    }
    
    /// ArtworkModel 변환
    private func convertToUIModels(from artworkModels: [ArtworkFeatureInterface.ArtworkModel]) -> [ListDataModel] {
        return artworkModels.map {
            ListDataModel(
                id: $0.id,
                title: $0.title,
                username: $0.artist.name,
                profileImageUrlString: $0.artist.profileImageUrl,
                thumbnailImageUrlString: $0.artworkImageUrl
            )
        }
    }

    /// For SectionItems
    private func buildSectionItems(from uiModels: [ListDataModel]) -> [CollectionUISectionItem] {
        return uiModels.map { dataModel in
            let builder = ArtworkCellUIBuilder()
            builder.configure(dataModel: dataModel, listener: self)
            return .artworkThumbnail(builder)
        }
    }
}

extension ArtworkViewController: ArtworkCellUIBuilder.Listener {
    func modelSelected(dataModel: ListDataModel) {
        listener?.modelSelected(dataModel: dataModel)
    }
}
