//
//  PaymeGoCell.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/4/25.
//

import UIKit
import Core

final class PaymeGoCell: UICollectionViewCell {

    static let identifier = "PaymeGoCell"

    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        view.layer.masksToBounds = false

        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .appColor.secondary
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
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
private extension PaymeGoCell {

    func setupView() {
        let stack = UIStackView(arrangedSubviews: [circleView, titleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8

        contentView.addSubview(stack)

        stack.setConstraint(.xCenter, from: self, .zero)
        stack.setConstraint(.yCenter, from: self, .zero)

        circleView.setConstraint(.width, from: self, CGFloat(integerLiteral: .eighty))
        circleView.setConstraint(.height, from: self, CGFloat(integerLiteral: .eighty))

        circleView.addSubview(iconImageView)
        
        iconImageView.setConstraint(.width, from: self, CGFloat(integerLiteral: .fiftySix))
        iconImageView.setConstraint(.height, from: self, CGFloat(integerLiteral: .fiftySix))
        iconImageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
    }
}
