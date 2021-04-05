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
    var status:String!
    var deskripsi:String!
    var gambarkoleksi:[String]!
    var mapvew:MapViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    func ngisi(view:MapViewController){
        mapvew = view
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
        
        
        if let detail = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController{
          
                detail.nama = namaResto.text
            detail.alamat1 = alamatResto.text
                detail.bukajam1 = status
            detail.rating1 = Double(ratingResto.text!)
                detail.fotodetail = gambar.image
                detail.deskripsi1 = deskripsi
            self.navigationController!.pushViewController(detail, animated: true)
            

    }
        DispatchQueue.main.async { [self] in
             let targetURL = NSURL(string: "http://maps.apple.com/?daddr=\(lokasiuser!),+CA&saddr=\(String(describing: lokasi!))")!
           /* if UIApplication.shared.canOpenURL(targetURL as URL) != nil{

                UIApplication.shared.openURL(targetURL as URL)
            }*/
    }
        
        

    }
    
}
