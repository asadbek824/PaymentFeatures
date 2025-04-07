//
//  FinicalServicesCell.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/6/25.
//

import UIKit
import Core

final class FinicalServicesCell: UICollectionViewCell {
    
    static let identifier = "FinicalServicesCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FinicalServicesCell {
    
    private func setupView() {
        contentView.backgroundColor = .clear

        hStack.backgroundColor = .white
        hStack.layer.cornerRadius = 8
        hStack.layer.shadowColor = UIColor.black.cgColor
        hStack.layer.shadowOpacity = 0.2
        hStack.layer.shadowOffset = CGSize(width: 4, height: 8)
        hStack.layer.shadowRadius = 10
        hStack.layer.masksToBounds = false
        hStack.isLayoutMarginsRelativeArrangement = true

        contentView.addSubview(hStack)
        hStack.addArrangedSubview(iconImageView)
        hStack.addArrangedSubview(titleLabel)
        
        hStack.setConstraint(.top, from: self, .zero)
        hStack.setConstraint(.left, from: self, .zero)
        hStack.setConstraint(.right, from: self, .zero)
        hStack.setConstraint(.bottom, from: self, .zero)
        
        iconImageView.setConstraint(.width, from: self, CGFloat(integerLiteral: .fortyEight))
        iconImageView.setConstraint(.height, from: self, CGFloat(integerLiteral: .fortyEight))
    }
    
    func configure(with title: String, image: UIImage?) {
        titleLabel.text = title
        iconImageView.image = image
    }
}
