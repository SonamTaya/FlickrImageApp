//
//  FlickrDataModel.swift
//  FlickrImageApp
//
//  Created by sonam taya on 2/3/22.
//

import Foundation

struct FlickrDataModel: Decodable {
    var photos: Photos?
    var stat: String?
}

struct Photos: Decodable {
    var page: Int?
    var pages: Int?
    var perpage: Int?
    var total: Int?
    var photo: [Photo]?
}

struct Photo: Decodable {
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var ispublic: Int?
    var isfriend: Int?
    var isfamily: Int?
}

//Getting Image URL
extension Photo {
    func getImageURL(farm:String,server:String,id:String,secret:String) -> URL? {
        return URL(string: "http://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg")
    }
}
