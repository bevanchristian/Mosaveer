//
//  FilterViewController.swift
//  cobaapi
//
//  Created by bevan christian on 31/03/21.
//

import UIKit
import Cosmos


class FilterViewController: UIViewController {

    @IBOutlet var apply: UIButton!
    @IBOutlet var openhours: UISegmentedControl!
   
    @IBOutlet var jarakInfo: UILabel!
    @IBOutlet var price: UISegmentedControl!
    @IBOutlet var distance: UISlider!
    var myview:ViewController!
    var distanceapi = 120000
    var open = Int.random(in: 0...1)
    var harga = Int.random(in: 0...3)
    //let restaurantData = RestaurantData()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"
        apply.layer.cornerRadius = 10.0
       
        // Do any additional setup after loading the view.
    
    }
    
    @IBAction func priceAction2(_ sender: UISegmentedControl) {
        harga = sender.selectedSegmentIndex
    }
  
    func isi(vie:ViewController){
        myview = vie
    }
    
    @IBAction func distanceAction(_ sender: UISlider) {
        distanceapi = Int(sender.value)
        let float = distanceapi/1000
        jarakInfo.text = "\(float) Km"
    }
    
    @IBAction func openAction(_ sender: UISegmentedControl) {
        open = sender.selectedSegmentIndex
    }
    @IBAction func doneButton(_ sender: Any) {
        myview.collectionView?.isSkeletonable = true
        myview.collectionView?.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .greenSea), animation: nil, transition: .crossDissolve(0.4))
        myview.restaurantData.ubahfilter(myView: myview, tipe: 0, sudahAda: false, distance: distanceapi, bukak: open, rating: harga)
        performSelector(inBackground: #selector(manggilData), with: nil)
        dismiss(animated: true)
        print("donefilter")
    }
    
     @IBAction func applyAction(_ sender: Any) {
        myview.collectionView?.isSkeletonable = true
        myview.collectionView?.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .greenSea), animation: nil, transition: .crossDissolve(0.4))
        myview.restaurantData.ubahfilter(myView: myview, tipe: 0, sudahAda: false, distance: distanceapi, bukak: open, rating: harga)
        performSelector(inBackground: #selector(manggilData), with: nil)
        dismiss(animated: true)
     }
    
    @objc func manggilData(){
        myview.restaurantData.restoranarray.removeAll()
        //myview.restaurantData.ubahfilter(myView: myview, tipe: 0, sudahAda: false, distance: distanceapi, bukak: open, rating: harga)
    }
   

}
