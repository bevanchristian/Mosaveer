//
//  anotate.swift
//  cobaapi
//
//  Created by bevan christian on 01/04/21.
//

import Foundation
import MapKit

class Anotate: NSObject,MKAnnotation {
    // nama
    let title: String?
    // bintang
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    // gambar
    var gambarFinal:UIImage!
    // alamat
    var alamat:String
    var lokasifull:String
    init(title:String,subtitle:String,coordinate:CLLocationCoordinate2D,gambar:UIImage,alamat:String,lokasifull:String) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.gambarFinal = gambar
        self.alamat = alamat
        self.lokasifull = lokasifull
        
    }
    // method view for ini dipakai ketika tiap ada anotation
   

}
