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

enum CarouselConstants {
    static let dummyItemCount = 2
    static let sideItemScale: CGFloat = 0.9
    static let spacing: CGFloat = 8
    static let visibleItemWidth: CGFloat = 0.8
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
    
    private var actualPage: Int {
        return (currentPage - CarouselConstants.dummyItemCount).clamped(to: 1...data.count)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
        configureInfinityScroll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            text: "\(currentPage - 2)/\(data.count)",
            fontStyle: .p5
        )
    }
    
    // MARK: Infinity scroll
    
    private func configureInfinityScroll() {
        let cellWidth = magazineCarousel.frame.width * CarouselConstants.visibleItemWidth + CarouselConstants.spacing
        let targetOffset = CGPoint(
            x: cellWidth * CGFloat(CarouselConstants.dummyItemCount),
            y: 0
        )
        magazineCarousel.setContentOffset(targetOffset, animated: false)
    }
}

// MARK: - MagazineViewPresentable

extension MagazineViewController: MagazineViewPresentable {
    func reloadMagazineCarousel(magazineModels: [MagazineModel]) {
        self.data = magazineModels
        magazineCarousel.reloadData()
        configureInfinityScroll()
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
        return CarouselConstants.dummyItemCount * 2 + data.count
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
        
        let dataIndex = calculateDataIndex(for: indexPath.row)
        cell.configure(with: data[dataIndex])
        
        return cell
    }
    
    private func calculateDataIndex(for row: Int) -> Int {
        let totalItems = CarouselConstants.dummyItemCount * 2 + data.count
        switch row {
        case 0..<CarouselConstants.dummyItemCount:
            return data.count - CarouselConstants.dummyItemCount + row
        case totalItems - CarouselConstants.dummyItemCount..<totalItems:
            return row - (totalItems - CarouselConstants.dummyItemCount)
        default:
            return row - CarouselConstants.dummyItemCount
        }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentXOffset = scrollView.contentOffset.x
        let numberOfItems = CarouselConstants.dummyItemCount * 2 + data.count
        let cellWidth = magazineCarousel.frame.width * CarouselConstants.visibleItemWidth + CarouselConstants.spacing
        
        if Int(contentXOffset) > Int(cellWidth) * (numberOfItems - CarouselConstants.dummyItemCount) {
            let targetOffset = CGPoint(
                x: cellWidth * CGFloat(CarouselConstants.dummyItemCount),
                y: 0
            )
            magazineCarousel.setContentOffset(targetOffset, animated: false)
        } else if Int(contentXOffset) <= Int(cellWidth) {
            let targetOffset = CGPoint(
                x: cellWidth * CGFloat(numberOfItems - CarouselConstants.dummyItemCount - 1),
                y: 0
            )
            magazineCarousel.setContentOffset(targetOffset, animated: false)
        }
    }
}
