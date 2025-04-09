//
//  ReceiptModel.swift
//  Core
//
//  Created by Sukhrob on 09/04/25.
//

import Foundation

/// A simple model representing the Payment Success screen data
struct ReceiptModel {
    let title: String
    let description: String
    
    /// Actions or buttons displayed at the bottom of the screen
    let bottomActions: [BottomAction]
}

/// A sub-model to represent the bottom action items
struct BottomAction: Identifiable {
    let id = UUID()
    let iconName: String
    let text: String
}

