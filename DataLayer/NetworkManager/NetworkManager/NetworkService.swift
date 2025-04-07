//
//  NetworkService.swift
//  NetworkManager
//
//  Created by Asadbek Yoldoshev on 4/3/25.
//

import Foundation
import Combine
import UIKit

struct NetworkServiceConfig {
    static var isLogEnabled = true
}

let showJsonLog = true

final public class NetworkService {
    
    private init() { }
    
    public static let shared = NetworkService()
    
    public func request<T: Decodable>(
        url: String,
        decode: T.Type,
        method: HTTPMethod,
        queryParameters: [String: String]? = nil,
        body: [String: Any]? = nil,
        header: [String: String] = [:]
    ) async throws -> T {
        
//        let baseUrlDev = ""
        let baseUrlProd = ""
        
        guard var components = URLComponents(string: baseUrlProd+url) else {
            throw NetworkError.invalidURL
        }
        self.log("REQUEST------------------ \(url)", force: true)
        
        if let queryParameters = queryParameters {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            self.log("queryParameters: \(queryParameters)", force: true)
        }
        
        guard let finalURL = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
    
        self.log("-------------------------HEADER---------------------------------")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.log("Content-Type", "application/json","\n")
        request.setValue("iOS", forHTTPHeaderField: "Accept-Device")
        
        if let lang = UserDefaults.standard.object(forKey: "language") as? String {
            request.setValue(lang, forHTTPHeaderField: "Accept-Language")
        }
        
        if let token = UserDefaults.standard.string(forKey: "token") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        if !header.isEmpty {
            header.forEach { (key, value) in
                request.setValue(key, forHTTPHeaderField: value)
            }
        }
        
        if let deviceId = await UIDevice.current.identifierForVendor?.uuidString {
            self.log("DeviceId", deviceId, force: true)
        }
        
        if let countryCode = UserDefaults.standard.string(forKey: "countryCode") {
            request.setValue(countryCode, forHTTPHeaderField: "Accept-Country")
        }
        
        if let body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            
            self.log("body: \(body)", force: true)
        } else {
            self.log("BODY IS EMPTY", url)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            
            guard let safeResponse = response as? HTTPURLResponse,
                      safeResponse.statusCode >= 200,
                      safeResponse.statusCode < 300
            else {
                guard let response = (response as? HTTPURLResponse) else { throw NetworkError.requestFailed }
                
                self.log("error with code: \(response.statusCode)")
                throw NetworkError.incorrectStatusCode(response.statusCode)
            }
            
            self.log("in model", T.self, "✅", force: true)
           
            #if DEBUG
            self.log("\(try JSONSerialization.jsonObject(with: data))")
            #endif
            
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(T.self, from: data)

            return decodedObject
        } catch {
            self.log(
                "in model", T.self,
                "🛑🛑🛑🛑🛑🛑🛑 DECODE ERROR",
                error,
                force: true
            )
            throw error
        }
    }
}

