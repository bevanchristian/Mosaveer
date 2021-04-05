//
//  anotateview.swift
//  cobaapi
//
//  Created by bevan christian on 04/04/21.
//

import Foundation

import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      // 1
      guard let artwork = newValue as? Anotate else {
        return
      }
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

      // 2
      markerTintColor = artwork.markerTintColor
      if let letter = try? artwork.identitas {
        glyphText = String(letter)
    
      }
    }
  }
}
