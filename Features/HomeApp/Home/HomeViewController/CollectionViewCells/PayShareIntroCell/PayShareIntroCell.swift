//
//  PayShareIntroCell.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/23/25.
//

import UIKit
import Core

final class PayShareIntroCell: UICollectionViewCell {

    static let identifier = "PayShareIntroCell"

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with image: UIImage?, title: String) {
        
    }
}

// MARK: - Setup
private extension PayShareIntroCell {

    func setupView() {
        backgroundColor = .red
        
    }
}
