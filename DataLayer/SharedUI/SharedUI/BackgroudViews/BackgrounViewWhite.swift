//
//  BackgrounViewWhite 2.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 4/28/25.
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
