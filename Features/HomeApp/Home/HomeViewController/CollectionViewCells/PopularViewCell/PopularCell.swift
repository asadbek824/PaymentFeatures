//
//  PopularCell.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/7/25.
//

import UIKit
import Core

final class PopularCell: UICollectionViewCell {
    
    static let identifier = "PopularCell"
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let bannerTextLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
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

    func configure(with image: String?, title: String) {
        bannerTextLabel.text = title
        if let imageUrlString = image, let url = URL(string: imageUrlString) {
            loadImage(from: url)
        } else {
            bannerImageView.image = nil
        }
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.bannerImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}

// MARK: - Setup View
private extension PopularCell {
    
    func setupView() {
        addSubview(bannerImageView)
        bannerImageView.setConstraint(.top, from: self, .zero)
        bannerImageView.setConstraint(.left, from: self, .zero)
        bannerImageView.setConstraint(.right, from: self, .zero)
        bannerImageView.setConstraint(.bottom, from: self, .zero)
        
        bannerImageView.addSubview(bannerTextLabel)
        bannerTextLabel.setConstraint(.yCenter, from: bannerImageView, .zero)
        bannerTextLabel.setConstraint(.xCenter, from: bannerImageView, .zero)
    }
}
