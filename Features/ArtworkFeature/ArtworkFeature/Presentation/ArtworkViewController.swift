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
    func circleButtonListener(action: CircleButtonListener)
    func didBecomeActive()
    func networoErrorListener(action: NetworkErrorUIListener)
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
            self?.listener?.circleButtonListener(action: action)
        }
        let hostingController = UIHostingController(rootView: circleButton)
        hostingController.view.backgroundColor = .clear
        return hostingController.view
    }()
    
    private lazy var networkErrorUI: UIView = {
        let ui = NetworkErrorUI { [weak self] action in
            self?.listener?.networoErrorListener(action: action)
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
            uiModel.profileImageUrlString = artworkModel.profileImageUrlString
            uiModel.thumbnailImageUrlString = artworkModel.thumbnailImageUrlString
            uiModel.title = artworkModel.title
            uiModel.username = artworkModel.username
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

protocol ArtworkCellUIBuilderListener: AnyObject {
    func modelSelected(dataModel: ListDataModel)
}

final class ArtworkCellUIBuilder: CollectionUIBuildable {
    typealias Listener = ArtworkCellUIBuilderListener
    
    weak var listener: Listener?
    
    var dataModel: ListDataModel?
    
    func configure(dataModel: ListDataModel, listener: Listener?) {
        self.dataModel = dataModel
        self.listener = listener
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ArtworkCell.id,
            for: indexPath
        ) as? ArtworkCell else {
            return .init()
        }
        
        guard let dataModel else { return .init() }
        
        cell.configure(dataModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let inset: CGFloat = 16.0
        
        let length = screenWidth - (inset * 2)
        
        return .init(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: 16, left: 0, bottom: 52, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataModel else { return }
        listener?.modelSelected(dataModel: dataModel)
    }
    
}
