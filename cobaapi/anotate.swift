//
//  anotate.swift
//  cobaapi
//
//  Created by bevan christian on 01/04/21.
//

import Foundation
import MapKit

class Anotate: NSObject,MKAnnotation {
    let namaResto: String?
    let bintang: String?
    let coordinate: CLLocationCoordinate2D
    
    init(namaResto:String,bintang:String,coordinate:CLLocationCoordinate2D) {
        self.namaResto = namaResto
        self.bintang = bintang
        self.coordinate = coordinate
    }
    // method view for ini dipakai ketika tiap ada anotation
   

}
