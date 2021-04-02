//
//  FloatMapViewController.swift
//  cobaapi
//
//  Created by bevan christian on 02/04/21.
//

import UIKit

class FloatMapViewController: UIViewController {

    @IBOutlet var gambar: UIImageView!
    @IBOutlet var alamatResto: UILabel!
    @IBOutlet var ratingResto: UILabel!
    @IBOutlet var namaResto: UILabel!
    var lokasi:String!
    var lokasiuser:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var closeOutlet: UIButton!
    @IBAction func close(_ sender: Any) {
        //dismiss(animated: true)
        print("nutup")
        
    }
    @IBAction func getdirection(_ sender: Any) {
        if lokasiuser == nil{
            lokasiuser = "35.702069,139.775327"
        }
        let targetURL = NSURL(string: "http://maps.apple.com/?daddr=\(lokasiuser!),+CA&saddr=\(String(describing: lokasi!))")!
        if UIApplication.shared.canOpenURL(targetURL as URL) != nil{
            UIApplication.shared.open(targetURL as URL)
        }
       // UIApplication.shared.open(targetURL as URL, options: .init(minimumCapacity: 10), completionHandler: nil)
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
