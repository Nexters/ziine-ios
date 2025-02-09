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
    func didBecomeActive()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
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
        let cv = CollectionUI(listener: self)
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
        var uiModels: [ListDataModel] = []
        
        var mock1 = ListDataModel()
        mock1.username = "username 1"
        mock1.title = "artwork title 1"
        
        var mock2 = ListDataModel()
        mock2.username = "username 2"
        mock2.title = "artwork title 2"
        
        uiModels = [mock1, mock2]
        
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
            builder.configure(dataModel: dataModel)
            
            sectionItems.append(.artworkThumbnail(builder))
        }
        
        var sections: [CollectionUISection] = []
        sections.append(.default(sectionItems))

        collectionUI.configure(
            sections: sections
        )
    }
    
}
extension ArtworkViewController: CollectionUIListener {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listener?.scrollViewDidScroll(scrollView)
    }
    
}

final class ArtworkCellUIBuilder: CollectionUIBuildable {
    
    var dataModel: ListDataModel?
    
    func configure(dataModel: ListDataModel) {
        self.dataModel = dataModel
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
    
}
