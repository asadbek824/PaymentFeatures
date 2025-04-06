//
//  BannerModel.swift
//  Core
//
//  Created by Asadbek Yoldoshev on 4/6/25.
//

import Foundation

public struct BannerModel: Codable {
    public let id: Int
    public let media: BannerMedia
     
    public init(id: Int, media: BannerMedia) {
        self.id = id
        self.media = media
    }
}

public struct BannerMedia: Codable {
    public  let id: Int
    public let src: String?
    public let type: String?
    public  let title: String
    
    public init(id: Int, src: String?, type: String?, title: String) {
        self.id = id
        self.src = src
        self.type = type
        self.title = title
    }
}
