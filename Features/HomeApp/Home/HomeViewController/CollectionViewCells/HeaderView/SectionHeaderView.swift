//
//  SectionHeaderView.swift
//  Home
//
//  Created by Asadbek Yoldoshev on 4/6/25.
//

import UIKit
import Core

final class SectionHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "headerView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        addSubview(titleLabel)
        
        titleLabel.setConstraint(.top, from: self, .zero)
        titleLabel.setConstraint(.bottom, from: self, .zero)
        titleLabel.setConstraint(.left, from: self, CGFloat(integerLiteral: .sixteen))
        titleLabel.setConstraint(.right, from: self, CGFloat(integerLiteral: .sixteen))
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
