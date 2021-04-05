//
//  MapSettingViewController.swift
//  cobaapi
//
//  Created by bevan christian on 05/04/21.
//

import UIKit

class MapSettingViewController: UIViewController {

    @IBOutlet var setting: UISegmentedControl!
    var masjidarray=[Anotate]()
    var restoarray=[Anotate]()
    var mapview:MapViewController!
    
    
    var countresto = 0
    var countmasjid = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func dapetinview(myview:MapViewController){
        mapview = myview
    }
    
    
    
    @IBAction func settingAction2(_ sender: UISegmentedControl) {
        
      // all
        if sender.selectedSegmentIndex == 0 {
            
            mapview.masukin()
            countresto = 0
            countmasjid = 0
        
           
           // resto
        }else if sender.selectedSegmentIndex == 1{
            if countresto > 1{
                mapview.masukinresto()
            }
            
            mapview.map.removeAnnotations(masjidarray)
            countresto += 1
            
           
        // masjid
        }else if sender.selectedSegmentIndex == 2{
            if countmasjid > 1{
                mapview.masukinmasjid()
            }
            mapview.map.removeAnnotations(restoarray)
            countmasjid += 1
      
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
