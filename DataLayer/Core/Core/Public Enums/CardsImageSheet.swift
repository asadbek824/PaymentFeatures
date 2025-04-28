//
//  CardsImageSheet.swift
//  Core
//
//  Created by Sukhrob Bekmuratov on 4/19/25.
//

import Foundation
import SwiftUI
import DesignSystem

public enum CardsImageSheet {
    case TBC
    case Humo
    case Uzcard
    
    public var paymentStatusIcon: UIImage {
        switch self {
        case .TBC: return (AssetsKitDummy.Image.TBC)
        case .Humo: return (AssetsKitDummy.Image.Humo)
        case .Uzcard: return (AssetsKitDummy.Image.Uzcard)
        }
    }
}

