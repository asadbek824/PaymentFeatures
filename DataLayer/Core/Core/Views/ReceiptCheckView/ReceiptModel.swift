//
//  ReceiptModel.swift
//  Core
//
//  Created by Sukhrob on 09/04/25.
//

import Foundation

protocol Displayable {
    var title: String { get }
    var description: String { get }
}


struct ReceiptModel: Displayable {
    var title: String
    var description: String
}
