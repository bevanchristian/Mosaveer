//
//  foursquares.swift
//  cobaapi
//
//  Created by bevan christian on 26/03/21.
//

import Foundation


struct foursquares:Codable {
    var response:mygroups
}
struct mygroups : Codable {
    var groups:[myitems]
}
struct myitems :Codable {
    var items :[myvenue]
}
struct myvenue : Codable {
    var venue:venue
}
struct venue:Codable {
    var id:String
    var name:String
    var location:mylokasi
}
struct mylokasi:Codable {
    var address:String
    var crossStreet:String
    var lat:Double
    var lng:Double
}
