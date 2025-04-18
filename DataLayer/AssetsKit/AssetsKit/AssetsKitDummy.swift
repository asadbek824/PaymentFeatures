//
//  AssetsKitDummy.swift
//  AssetsKit
//
//  Created by Asadbek Yoldoshev on 4/6/25.
//

import Foundation
import UIKit

public final class AssetsKitDummy {
    public enum Image {
        public static var paymego: UIImage {
            return UIImage(named: "paymego", in: .assetsKit, compatibleWith: nil)!
        }
        public static var cartholder: UIImage {
            return UIImage(named: "cartholder", in: .assetsKit, compatibleWith: nil)!
        }
        public static var scaner: UIImage {
            return UIImage(named: "scaner", in: .assetsKit, compatibleWith: nil)!
        }
        public static var transfer: UIImage {
            return UIImage(named: "transfer", in: .assetsKit, compatibleWith: nil)!
        }
        public static var tbsbank: UIImage {
            return UIImage(named: "tbsbank", in: .assetsKit, compatibleWith: nil)!
        }
        public static var payshareLockscreenLogo: UIImage? {
            return UIImage(named: "payshare.lockscreen", in: .assetsKit, compatibleWith: nil)
        }
        public static var payshare: UIImage {
            return UIImage(named: "payshare", in: .assetsKit, compatibleWith: nil)!
        }
        public static var paysharegray: UIImage {
            return UIImage(named: "paysharegray", in: .assetsKit, compatibleWith: nil)!
        }
        
        public enum CardsImage {
            public static var cardRed: UIImage {
                return UIImage(named: "cardRed", in: .assetsKit, compatibleWith: nil)!
            }
            public static var cardBlue: UIImage {
                return UIImage(named: "cardBlue", in: .assetsKit, compatibleWith: nil)!
            }
            public static var cardPink: UIImage {
                return UIImage(named: "cardPink", in: .assetsKit, compatibleWith: nil)!
            }
            public static var cardCyan: UIImage {
                return UIImage(named: "cardCyan", in: .assetsKit, compatibleWith: nil)!
            }
            public static var cardYellow: UIImage {
                return UIImage(named: "cardYellow", in: .assetsKit, compatibleWith: nil)!
            }
        }
    }
}
