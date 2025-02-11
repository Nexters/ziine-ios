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
    
    private var totalItemCount: Int = 10 // for test
    private var currentPage: Int = 1 {
        didSet {
            updatePageCounter()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Components
    private lazy var magazineCarousel: UICollectionView = {
        let carouselLayout = MagazineCarouselLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        
        cv.isPagingEnabled = false
        cv.decelerationRate = .fast
        cv.backgroundColor = ZiineColor.uiColor(.p100)
        cv.showsHorizontalScrollIndicator = false
        cv.register(MagazineCell.self, forCellWithReuseIdentifier: MagazineCell.identifier)
        
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    private var carouselPageCounter: UILabel = {
        let label = UILabel()
        label.textColor = ZiineColor.uiColor(.p500)
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(82)
        }
        
        updatePageCounter() // 초기 페이지 설정
    }
    
    private func updatePageCounter() {
        carouselPageCounter.setTextWithLineHeight(
            text: "\(currentPage)/\(totalItemCount)",
            fontStyle: .p5
        )
    }
}

extension MagazineViewController: MagazineViewPresentable {
    func reloadMagazineCarousel(magazineModels: [MagazineFeatureInterface.MagazineModel]) {
        print(#function)
    }
}

// MARK: - CollectionView DataSource & Delegate
extension MagazineViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return totalItemCount
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MagazineCell.identifier,
            for: indexPath
        ) as? MagazineCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

// MARK: - Scroll View Delegate (for Page Tracking)
extension MagazineViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let layout = magazineCarousel.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        let estimatedIndex = targetContentOffset.pointee.x / cellWidthIncludingSpacing
        currentPage = Int(round(estimatedIndex)) + 1
    }
}
