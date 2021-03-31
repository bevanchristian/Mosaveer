//
//  restaurant.swift
//  cobaapi
//
//  Created by bevan christian on 30/03/21.
//

import Foundation
import UIKit
struct restaurant {
    var nama : String = ""
    var address:String=""
    var crossStreet:String=""
    var lokasiMap :String = ""
    var rating :Double = 0.0
    var deskription:String=""
    var statusOpen :String=""
    var banner :String=""
    var gambar = [String]()
    var veneu:myvenueinfo? = nil
    var mygroupp = [myitems]()
    var gambarFinal:UIImage!
    var foursquare:mygroups? = nil
    var cekfoto = 0
    var count = 0
    var id :String = "" 
}
