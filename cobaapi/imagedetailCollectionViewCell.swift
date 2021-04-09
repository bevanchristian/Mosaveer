//
//  imagedetailCollectionViewCell.swift
//  cobaapi
//
//  Created by bevan christian on 06/04/21.
//

import UIKit

class imagedetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imagedetail: UIImageView!
    func makeRounded() {
    
        imagedetail.layer.borderWidth = 1
        imagedetail.layer.masksToBounds = false
      //  imagedetail.layer.borderColor = UIColor.ba
        imagedetail.layer.cornerRadius = imagedetail.frame.height/2
        //This will change with corners of image and height/2 will make this circle shape
        imagedetail.clipsToBounds = true
   }
  
}
