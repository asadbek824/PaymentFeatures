//
//  UIColor.swift
//  PaymeFituares
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import UIKit

public extension UIColor {
    static var appColor = AppColor()
    
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static func rgbAll(_ value: CGFloat) -> UIColor {
        UIColor(red: value/255, green: value/255, blue: value/255, alpha: 1)
    }
}

public struct AppColor {
    public let primary: UIColor = .rgb(101, 200, 201)
    public let secondary: UIColor = .rgbAll(255)
    public let green: UIColor = .rgb(129, 179, 107)
}

