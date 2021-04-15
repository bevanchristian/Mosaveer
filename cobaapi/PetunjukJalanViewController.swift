//
//  PetunjukJalanViewController.swift
//  cobaapi
//
//  Created by bevan christian on 14/04/21.
//

import UIKit

class PetunjukJalanViewController: UIViewController {

    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var petunjukLabel: UILabel!
    @IBOutlet var waktuLabel: UILabel!
    
    var distance:String = ""
    var petunjuk = [String]()
    var waktulabel:String = ""
    var simpan = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        distanceLabel.text = distance + "Km"

        waktuLabel.text = waktulabel + "min"
        if petunjuk.count != 0 {
            for x in 0...petunjuk.count-1{
                simpan += petunjuk[x]
    
            }
            petunjukLabel.text = simpan
        }
     
        // Do any additional setup after loading the view.
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
