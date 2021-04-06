//
//  DetailViewController.swift
//  cobaapi
//
//  Created by bevan christian on 27/03/21.
//

import UIKit
class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
   
    
   
    @IBOutlet weak var gambar: UICollectionView!
    
    var nama:String?
    var idresto:String?
    var alamat1:String?
    var fotodetail:UIImage?
    var bukajam1:String?
    var rating1:Double?
    var deskripsi1:String?
    var gambarslide:[String]?
    var gambarslide1 = [UIImage]()
    @IBOutlet var namaRestoran: UILabel!
    
    
    @IBOutlet weak var alamat: UILabel!
    
    @IBOutlet weak var bukajam: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    
    @IBOutlet weak var bintang: UILabel!
    
    
  
    @IBOutlet weak var deskripsi: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        gambar.delegate = self
        gambar.dataSource = self
        title = "Detail Pages"
        namaRestoran.text = nama
        print(idresto)
        alamat.text = alamat1
        bukajam.text = bukajam1
        rating.text = String(rating1 ?? 0)
        deskripsi.text = deskripsi1
        if rating1 ?? 0 < 2 {
            bintang.text = "⭐️"
        } else if rating1 ??  2 < 4 {
            bintang.text = "⭐️⭐️"
        }else if rating1 ??  4 < 6 {
            bintang.text = "⭐️⭐️⭐️"
        }else if rating1 ??  6 < 8 {
            bintang.text = "⭐️⭐️⭐️⭐️"
        }else if rating1 ??  8 <= 10 {
            bintang.text = "⭐️⭐️⭐️⭐️⭐️"
    }
        if gambarslide != nil{
            for x in 0...gambarslide!.count-1 {
                if let datafoto = try? gambarslide![x]{
                    if let fotoURL = try? Data(contentsOf: URL(string: datafoto)! ) {
                        if let foto = UIImage(data: fotoURL) {
                             //self?.foto = foto
                            gambarslide1.append(foto)
                            // print(gambarFinal)
                        }
                    }}
        }
        
                
        
        
        
        
        
      //  fotoDetail.image = fotodetail
        
        
       
      
        

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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if gambarslide1 != nil {
            return gambarslide1.count
        }else{
            return 0
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gambarReview", for: indexPath) as! imagedetailCollectionViewCell
        cell.imagedetail.image = gambarslide1[indexPath.item]
            
            return cell
        
       
    }
    

}
