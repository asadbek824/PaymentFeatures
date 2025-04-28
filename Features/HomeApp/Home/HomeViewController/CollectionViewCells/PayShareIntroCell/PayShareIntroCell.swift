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
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with image: UIImage?, title: String) {
        iconImageView.image = image
        titleLabel.text = title
    }
}

// MARK: - Setup
private extension PayShareIntroCell {

    func setupView() {
        iconImageView.layer.shadowColor = UIColor.black.cgColor
        iconImageView.layer.shadowOpacity = 0.2
        iconImageView.layer.shadowOffset = CGSize(width: 4, height: 8)
        iconImageView.layer.shadowRadius = 10
            


        contentView.addSubview(iconImageView)
        iconImageView.addSubview(titleLabel)
        
        
        iconImageView.setConstraint(.top, from: self, .zero)
        iconImageView.setConstraint(.left, from: self, .zero)
        iconImageView.setConstraint(.right, from: self, .zero)
        iconImageView.setConstraint(.bottom, from: self, .zero)
        
        titleLabel.setConstraint(.top, from: iconImageView, .zero)
        titleLabel.setConstraint(.left, from: iconImageView, CGFloat(integerLiteral: .twenty))
        titleLabel.setConstraint(.bottom, from: iconImageView, .zero)
    }
}

