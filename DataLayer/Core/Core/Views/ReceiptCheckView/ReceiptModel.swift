//
//  ReceiptModel.swift
//  Core
//
//  Created by Sukhrob on 09/04/25.
//

import SwiftUI

// Define a protocol for displayable content.
public protocol Displayable {
    var iconDetails: (icon: String, color: Color) {get}
    var title: String { get }
    var description: String { get }
}

