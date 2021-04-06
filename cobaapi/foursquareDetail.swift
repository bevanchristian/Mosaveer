//
//  foursquareDetail.swift
//  cobaapi
//
//  Created by bevan christian on 27/03/21.
//

import Foundation

struct detailinfo:Codable {
    var response : myvenueinfo
}
struct myvenueinfo:Codable {
    var venue : photos
}
struct photos:Codable {
    var rating : Double?
    var photos : groups
    var tips : mytips
    var hours : jam?
    var description :String?
    var bestPhoto : myBest
    var page:mypage?
}

struct mytips:Codable {
    var groups: [tipsdalam]
}

struct tipsdalam :Codable {
    var items:[textdalam]
}

struct textdalam:Codable {
    var text:String
}
struct myBest:Codable{
    var prefix : String
    var suffix : String
}
struct mypage:Codable {
    var pageInfo : myPageInfo
}

struct myPageInfo:Codable {
    var banner : String?
}

struct jam : Codable {
    var status : String?

}
struct groups:Codable {
    var groups : [detailfoto]
}

struct detailfoto: Codable{
    var items: [foto]
}
struct foto:Codable {
    var prefix : String
    var suffix : String
}
