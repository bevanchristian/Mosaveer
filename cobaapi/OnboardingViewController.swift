//
//  OnboardingViewController.swift
//  cobaapi
//
//  Created by bevan christian on 07/04/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    var firsttime:Bool!
    @IBOutlet var getstart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        firsttime = UserDefaults.standard.bool(forKey: "firsttime")
        // Do any additional setup after loading the view.
        if (firsttime)
        {
            UserDefaults.standard.set(true, forKey: "firsttime")
            let pindah = storyboard?.instantiateViewController(identifier: "utama") as! ViewController
            navigationController?.pushViewController(pindah, animated: true)
        }
        
    }
    

    @IBAction func GetStartAction(_ sender: Any) {

        //check first launched
        UserDefaults.standard.set(true, forKey: "firsttime")
        let pindah = storyboard?.instantiateViewController(identifier: "utama") as! ViewController
        navigationController?.pushViewController(pindah, animated: true)
        
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
