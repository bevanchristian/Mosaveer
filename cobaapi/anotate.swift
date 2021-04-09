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
    // lokasi
    let coordinate: CLLocationCoordinate2D
    // gambar
    var gambarFinal:UIImage!
    // alamat
    var alamat:String
    var lokasifull:String
    var identitas:String
    var statusopen:String
    var deskripsi:String
    var gambar = [String]()
    var imageanotate:UIImage!

    var markerTintColor: UIColor  {
      switch identitas {
      case "resto":
        return .blue
      case "masjid":
        return .cyan
      default:
        return .green
      }
    }
    
    

    init(title:String,subtitle:String,coordinate:CLLocationCoordinate2D,gambarfinal:UIImage,alamat:String,lokasifull:String,identitas:String,statusopen:String,deskripsi:String,gambar:[String],imageanotate:UIImage) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.gambarFinal = gambarfinal
        self.alamat = alamat
        self.lokasifull = lokasifull
        self.identitas = identitas
        self.statusopen = statusopen
        self.deskripsi = deskripsi
        self.gambar = gambar
        self.imageanotate = imageanotate
    }
    // method view for ini dipakai ketika tiap ada anotation
   

}
