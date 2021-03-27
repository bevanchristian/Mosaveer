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
    var photos : groups
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
