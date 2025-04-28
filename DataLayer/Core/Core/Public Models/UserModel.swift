//
//  UserModel.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation

public struct UserModel: Identifiable, Codable, Equatable, Hashable {
    public let id: Int
    public let fullName: String
    
    public init(id: Int, fullName: String){
        self.id = id
        self.fullName = fullName
    }
}
