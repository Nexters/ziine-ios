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
    private lazy var magazineCarousel: UICollectionView = {
        let carouselLayout = MagazineCarouselLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        cv.backgroundColor = ZiineColor.uiColor(.p100)
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
            $0.top.equalToSuperview().inset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(carouselPageCounter)
        carouselPageCounter.snp.makeConstraints {
            $0.top.equalTo(magazineCarousel.snp.bottom).inset(-12)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(48)
        }
    }
}

extension MagazineViewController: MagazineViewPresentable {
    func reloadMagazineCarousel(magazineModels: [MagazineFeatureInterface.MagazineModel]) {
        print(#function)
    }
}
