//
//  PopularBannerCarouselController.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/7/25.
//

import UIKit

final class PopularBannerCarouselController {
    private weak var collectionView: UICollectionView?
    private var sectionIndex: Int
    private var numberOfItems: Int
    private var timer: Timer?
    private var currentIndex: Int = 0

    init(collectionView: UICollectionView, sectionIndex: Int, numberOfItems: Int) {
        self.collectionView = collectionView
        self.sectionIndex = sectionIndex
        self.numberOfItems = numberOfItems
    }

    func start() {
        stop()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            self?.scroll()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    private func scroll() {
        guard numberOfItems > 0 else { return }

        currentIndex += 1

        if currentIndex >= numberOfItems {
            // reset to 0
            currentIndex = 0
        }

        let indexPath = IndexPath(item: currentIndex, section: sectionIndex)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
