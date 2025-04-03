//
//  NetworkError.swift
//  NetworkManager
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case incorrectStatusCode(Int)
    case couldnotDecodeModel(Error)
}

