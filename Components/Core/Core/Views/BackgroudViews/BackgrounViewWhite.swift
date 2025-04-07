//
//  BackgrounViewWhite.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/6/25.
//

import UIKit

final public class BackgrounViewWhite: UICollectionReusableView {
    
    public static let reuseIdentifier = "BackgrounViewWhite"
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final public class BackgrounViewWhiteIsCornerRadiusExsist: UICollectionReusableView {
    
    public static let reuseIdentifier = "BackgrounViewWhiteIsCornerRadiusExsist"
    
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

