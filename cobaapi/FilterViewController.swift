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
    @IBOutlet var rating: CosmosView!
    @IBOutlet var distance: UISlider!
    var myview:ViewController!
    var distanceapi = 10000
    var open = 1
    var harga = 1
    //let restaurantData = RestaurantData()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"
        rating.didFinishTouchingCosmos = { [self] rating in
            self.harga = Int(rating)
            print(harga)
        }
        // Do any additional setup after loading the view.
    
    }
    
    func isi(vie:ViewController){
        myview = vie
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
     
    }
    @IBAction func distanceAction(_ sender: UISlider) {
        distanceapi = Int(sender.value)
    }
    
    @IBAction func openAction(_ sender: UISegmentedControl) {
        open = sender.selectedSegmentIndex
    }
    
     @IBAction func applyAction(_ sender: Any) {
        performSelector(inBackground: #selector(manggilData), with: nil)
        dismiss(animated: true)
     }
    
    @objc func manggilData(){
        myview.restaurantData.restoranarray.removeAll()
        myview.restaurantData.ubahfilter(myView: myview, tipe: 0, sudahAda: false, distance: distanceapi, bukak: open, rating: harga)
    }
   

}
