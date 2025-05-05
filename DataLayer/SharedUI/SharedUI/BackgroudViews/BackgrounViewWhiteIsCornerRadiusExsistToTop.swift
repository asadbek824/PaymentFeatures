//
//  BackgrounViewWhiteIsCornerRadiusExsistToTop.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 4/28/25.
//

import UIKit

final public class BackgrounViewWhiteIsCornerRadiusExsistToTop: UICollectionReusableView {
    
    public static let reuseIdentifier = "BackgrounViewWhiteIsCornerRadiusExsistToTop"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 20
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
