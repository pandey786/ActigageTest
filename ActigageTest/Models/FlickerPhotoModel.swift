//
//  FlickerPhotoModel.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 19/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import ObjectMapper

struct FlickerPhotoResultModel: Mappable {
    
    var stat: String?
    var photos: FlickerPhotoListModel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        stat       <- map["stat"]
        photos       <- map["photos"]
    }
}

struct FlickerPhotoListModel: Mappable {
    
    var page: Int?
    var pages: Int?
    var perpage: Int?
    var total: String?
    var photo: [FlickerPhotoModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        page       <- map["page"]
        pages       <- map["pages"]
        perpage       <- map["perpage"]
        total       <- map["total"]
        photo       <- map["photo"]
    }
}

struct FlickerPhotoModel: Mappable {
    
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var ispublic: Bool?
    var isfriend: Bool?
    var isfamily: Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id       <- map["id"]
        owner       <- map["owner"]
        secret       <- map["secret"]
        server       <- map["server"]
        farm       <- map["farm"]
        title       <- map["title"]
        ispublic       <- map["ispublic"]
        isfriend       <- map["isfriend"]
        isfamily       <- map["isfamily"]
        
    }
    
    func getImageDownloadUrl() -> String {
        
        if let farm = self.farm, let server = self.server, let id = self.id, let secret = self.secret {
            
            let farmString = "https://farm" + String(farm)
            let serverString = ".staticflickr.com/" + server
            let idString = "/" + id
            let secretString = "_" + secret + "_m.jpg"
            
            let urlString = farmString + serverString + idString + secretString
            return urlString
        }
        
        return ""
    }
}

