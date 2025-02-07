//
//  MagazineViewController.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/7/25.
//

import UIKit
import MagazineFeatureInterface
import DesignSystem

internal import SnapKit

protocol MagazineViewPresentableListener: AnyObject {
    func itemSelected(indexPath: IndexPath)
}

final class MagazineViewController: UIViewController {
    var listener: MagazineViewPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: variables
    private var magazineCarousel: UICollectionView = {
        let cv = UICollectionView()
        cv.collectionViewLayout = MagazineCarouselLayout()
        return cv
    }()
    
    private var carouselPageCounter: UILabel = {
        let label = UILabel()
        label.font = ZiineFont.p5
        label.textColor = ZiineColor.uiColor(.p500)
        label.text = "2/16"
        return label
    }()
    
    func configureUI() {
        view.addSubview(magazineCarousel)
        magazineCarousel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(carouselPageCounter.snp.top).offset(-12)
        }
        
        view.addSubview(carouselPageCounter)
        carouselPageCounter.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
}

extension MagazineViewController: MagazineViewPresentable {
    func reloadMagazineCarousel(magazineModels: [MagazineFeatureInterface.MagazineModel]) {
        print(#function)
    }
}
