//
//  MagazineViewController.swift
//  MagazineFeature
//
//  Created by 이건우 on 2/7/25.
//

import UIKit
import CommonUI
import DesignSystem
import MagazineFeatureInterface

internal import SnapKit

protocol MagazineViewPresentableListener: AnyObject {
    func itemSelected(indexPath: IndexPath)
}

final class MagazineViewController: UIViewController {
    var listener: MagazineViewPresentableListener?
    
    private var data: [MagazineModel] = [
        MagazineModel(title: "매거진 제목1"),
        MagazineModel(title: "매거진 제목2"),
        MagazineModel(title: "매거진 제목3"),
        MagazineModel(title: "매거진 제목4")
    ]
    
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
    
    func configureUI() {
        view.backgroundColor = ZiineColor.uiColor(.g900)
        
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
        
        updatePageCounter()
    }
    
    private func updatePageCounter() {
        carouselPageCounter.setTextWithLineHeight(
            text: "\(currentPage)/\(data.count)",
            fontStyle: .p5
        )
    }
    
    // MARK: UI Components
    private lazy var magazineCarousel: UICollectionView = {
        let carouselLayout = MagazineCarouselLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        
        cv.backgroundColor = .clear
        cv.isPagingEnabled = false
        cv.decelerationRate = .fast
        cv.showsHorizontalScrollIndicator = false
        cv.register(MagazineCell.self, forCellWithReuseIdentifier: MagazineCell.identifier)
        
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    private var carouselPageCounter: CapsuleLabel = {
        let label = CapsuleLabel()
        label.font = ZiineFont.p5
        label.textColor = ZiineColor.uiColor(.p500)
        
        label.backgroundColor = ZiineColor.uiColor(.p100)
        label.layer.borderColor = ZiineColor.uiColor(.p150).cgColor
        label.layer.borderWidth = 1.5
        return label
    }()
}

// MARK: - MagazineViewPresentable

extension MagazineViewController: MagazineViewPresentable {
    func reloadMagazineCarousel(magazineModels: [MagazineModel]) {
        magazineCarousel.reloadData()
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
        let estimatedIndex = (targetContentOffset.pointee.x / cellWidthIncludingSpacing).rounded()
        currentPage = Int(estimatedIndex) + 1
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
        return data.count
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
        
        cell.configure(with: data[indexPath.row])
        return cell
    }
}
