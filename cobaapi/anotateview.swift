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
      glyphImage = artwork.imageanotate
        
        
    }
  }
}

class ArtworkView: MKAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      guard let artwork = newValue as? Anotate else {
        return
      }

      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
    let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
        mapsButton.setImage(.actions, for: .normal)
     rightCalloutAccessoryView = mapsButton

      image = artwork.imageanotate
      
      let detailLabel = UILabel()
      detailLabel.numberOfLines = 0
      detailLabel.font = detailLabel.font.withSize(12)
      detailLabel.text = artwork.subtitle
      detailCalloutAccessoryView = detailLabel
    }
  }
}


