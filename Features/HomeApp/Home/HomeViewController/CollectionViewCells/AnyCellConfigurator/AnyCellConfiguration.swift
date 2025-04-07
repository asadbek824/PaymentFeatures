//
//  AnyCellConfiguration.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/6/25.
//

import UIKit

enum HomeSectionItem {
    case balance(BalanceViewModel)
    case paymeGo([PaymeGoItemViewModel])
    case banner(BannerViewModel)
    case finicalServices([FinicalServicesViewModel])
    case popular([PopularViewModel])
}

protocol CollectionCellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UICollectionViewCell)
    func registerCell(on collectionView: UICollectionView)
}

struct AnyCellConfigurator {
    let reuseId: String
    let configure: (UICollectionViewCell) -> Void
    let register: (UICollectionView) -> Void
}
