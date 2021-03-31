//
//  ViewController.swift
//  cobaapi
//
//  Created by bevan christian on 26/03/21.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet var collectionView: UICollectionView?
    @IBOutlet var foto: UIImageView!
    // untuk nyimpen data
    var id = [String]()
  
    var idnamaDict = [String:String]()
    // untuk detail data resto
    var nama = [String]()
    var address = [String]()
    var crossStreet = [String]()
    var lokasiMap = [String]()
    var rating = [Double]()
    var deskription = [String]()
    var statusOpen = [String]()
    var banner = [String]()
    // untuk keperluan parsing pakek tipe data yang sebelume
    var foursquare:mygroups? = nil
    var veneu:myvenueinfo? = nil
    var mygroupp = [myitems]()
  
    // untuk loading foto resto
    var gambar = [String]()
    var gambarFinal = [UIImage]()
    var cekfoto = 0
    let restaurantData = RestaurantData()
    var milihapa = 0
    //var restoranarray = [restaurant]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView?.dataSource = self
        collectionView?.delegate = self
        title = "Moosafer"
       navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterOption))
        //tabBarController?.toolbarItems
        performSelector(inBackground: #selector(manggildata), with: nil)

        
        
    }
    // batas ahkir viewdidload
    @objc func manggildata() {
        print("mentoring")
        restaurantData.ubah(myView: self,tipe: 0,sudahAda: false)
    }
    
  
    
    
    @objc func filterOption(){
        // ini code untuk filter nampilin modal
        if let filter = storyboard?.instantiateViewController(identifier: "filter") as? FilterViewController{
            filter.modalPresentationStyle = .formSheet
   
            present(filter, animated: true, completion: nil)
                    }
        print("modal")
    }
    
     @objc func loaddata(){
        print("timerrrr")
        collectionView?.reloadData()
    }

    // data untuk homepage
    
    
    
    // untuk detail restor
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantData.restoranarray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "celljson", for: indexPath) as! jsondata
        //let isi = foursquare[indexPath.item].groups
        //print(isi)
        if milihapa == 0 {
            
            cell.Text.text = restaurantData.restoranarray[indexPath.item].nama
            print("reload data")
            //cell.Text.adjustsFontSizeToFitWidth = true
            cell.Text.lineBreakMode = .byWordWrapping
            cell.Text.numberOfLines = 0;
            cell.rating.text = String( restaurantData.restoranarray[indexPath.item].rating)
            cell.foto.image = restaurantData.restoranarray[indexPath.item].gambarFinal
            cell.openHour.text = restaurantData.restoranarray[indexPath.item].statusOpen
        }else if milihapa == 1{
            cell.Text.text = restaurantData.masjidarray[indexPath.item].nama
            print("reload data")
            //cell.Text.adjustsFontSizeToFitWidth = true
            cell.Text.lineBreakMode = .byWordWrapping
            cell.Text.numberOfLines = 0;
            cell.rating.text = String( restaurantData.masjidarray[indexPath.item].rating)
            cell.foto.image = restaurantData.masjidarray[indexPath.item].gambarFinal
            cell.openHour.text = restaurantData.masjidarray[indexPath.item].statusOpen
        }
    
       // print("masuk0")
       
            return cell
            
        
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("atasepindah")
        if let detail = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController{
            if let namaFix = try? self.nama[indexPath.row]{
                detail.nama = namaFix
                detail.idresto = id[indexPath.item]
            }
           
            self.navigationController!.pushViewController(detail, animated: true)
           // print("pindah")
        }
    }
    

    
   @IBAction func kontrol(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
      
            if restaurantData.restoranarray.isEmpty{
                milihapa = 0
                restaurantData.ubah(myView: self, tipe: 0,sudahAda: false)
            }else{
                milihapa = 0
                restaurantData.ubah(myView: self,tipe: 0,sudahAda: true)
            }
            
        }
        else if sender.selectedSegmentIndex == 1{
            if restaurantData.masjidarray.isEmpty{
                milihapa = 1
                restaurantData.ubah(myView: self, tipe: 1,sudahAda: false)
            }else{
                milihapa = 1
                restaurantData.ubah(myView: self,tipe: 1,sudahAda: true)
            }
            
        }
        
    }
    
  


}
