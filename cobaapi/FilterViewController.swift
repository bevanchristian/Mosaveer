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
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
     
    }
  
    
     @IBAction func applyAction(_ sender: Any) {
     }
   

}
