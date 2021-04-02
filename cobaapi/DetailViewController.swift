//
//  DetailViewController.swift
//  cobaapi
//
//  Created by bevan christian on 27/03/21.
//

import UIKit

class DetailViewController: UIViewController {
    var nama:String?
    var idresto:String?
    @IBOutlet var namaRestoran: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        namaRestoran.text = nama
        print(idresto)
      
        

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
