//
//  ViewController.swift
//  cobaapi
//
//  Created by bevan christian on 26/03/21.
//

import UIKit
import FloatingPanel
import SkeletonView
class ViewController: UIViewController,UICollectionViewDelegate,SkeletonCollectionViewDataSource,FloatingPanelControllerDelegate{
    
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "celljson"
    }
    

    @IBOutlet var collectionView: UICollectionView?

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
    var fpc:FloatingPanelController!
    //var restoranarray = [restaurant]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView?.dataSource = self
        collectionView?.delegate = self
       
        title = "Nearby"
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterOption))
        //tabBarController?.toolbarItems
        performSelector(inBackground: #selector(manggildata), with: nil)
        collectionView?.isSkeletonable = true
        collectionView?.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .greenSea), animation: nil, transition: .crossDissolve(0.4))

        
        
    }
    // batas ahkir viewdidload
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    
    @objc func manggildata() {
        print("mentoring")
        restaurantData.ubah(myView: self,tipe: 0,sudahAda: false)
        restaurantData.ubah(myView: self,tipe: 1,sudahAda: false)
    }
    
  
    
    
    @objc func filterOption(){
        // ini code untuk filter nampilin modal
        fpc = FloatingPanelController()
        guard let contentVC = storyboard?.instantiateViewController(identifier: "filter") as? FilterViewController else{
            return
        }
        contentVC.isi(vie: self)
        fpc.delegate = self
        fpc.set(contentViewController: contentVC)
        //fpc.isRemovalInteractionEnabled = true // Optional: Let it removable by a swipe-down
        UIView.animate(withDuration: 0.45) {
            self.fpc.move(to: .half, animated: true)
        }
        fpc.addPanel(toParent: self)
        UIView.animate(withDuration: 0.45) {
            self.fpc.move(to: .half, animated: true)
        }
    }
    
     @objc func loaddata(){
        print("timerrrr")
        collectionView?.reloadData()
    }

    // data untuk homepage
    
    
    
    // untuk detail restor
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if milihapa == 0{
            return restaurantData.restoranarray.count
        }else if milihapa == 1{
            return restaurantData.masjidarray.count
        }else{
            return 0
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "celljson", for: indexPath) as! jsondata
        //let isi = foursquare[indexPath.item].groups
        //print(isi)
        
        addTopAndBottomBorders(cell: cell)
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
        
        let tab = tabBarController as? TabbarViewController
        tab?.restoran = restaurantData.restoranarray
        tab?.masjid = restaurantData.masjidarray
       
        
        
    
       // print("masuk0")
       
            return cell
            
        
        
       
    }
    
    func addTopAndBottomBorders(cell:jsondata) {
        let thickness: CGFloat = 0.5
       let topBorder = CALayer()
       let bottomBorder = CALayer()
        topBorder.frame = CGRect(x: 15.0, y: 0.0, width: cell.frame.size.width-40, height: thickness)
        topBorder.backgroundColor = UIColor.gray.cgColor
       bottomBorder.frame = CGRect(x:0, y: cell.frame.size.height, width: cell.frame.size.width, height:thickness)
       bottomBorder.backgroundColor = UIColor.red.cgColor
       cell.layer.addSublayer(topBorder)
       cell.layer.addSublayer(bottomBorder)
    }
    
    func getrestaurant() -> [restaurant]{
        return restaurantData.restoranarray
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("atasepindah")
        if milihapa == 0 {
            if let detail = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController{
                if let namaFix = try? restaurantData.restoranarray[indexPath.item]{
                    detail.nama = namaFix.nama
                    detail.alamat1 = namaFix.address
                    detail.bukajam1 = namaFix.statusOpen
                    detail.rating1 = namaFix.rating
                    detail.fotodetail = namaFix.gambarFinal
                    detail.deskripsi1 = namaFix.deskription
                    detail.gambarslide = namaFix.gambar
                    print(namaFix.gambar)
                    print("INI FOTO APIK")
                    
                    
                   // detail.idresto = id[indexPath.item]
                }
               
                self.navigationController!.pushViewController(detail, animated: true)
               // print("pindah")
            }
        } else if   milihapa == 1{
            if let detail = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController{
                if let namaFix = try? restaurantData.masjidarray[indexPath.item]{
                    detail.nama = namaFix.nama
                    detail.alamat1 = namaFix.address
                    detail.bukajam1 = namaFix.statusOpen
                    detail.rating1 = namaFix.rating
                    detail.fotodetail = namaFix.gambarFinal
                    detail.deskripsi1 = namaFix.deskription
                    detail.gambarslide = namaFix.gambar
                    print(namaFix.gambar)
                    print("INI FOTO APIK")
                    
                   // detail.idresto = id[indexPath.item]
                }
               
                self.navigationController!.pushViewController(detail, animated: true)
               // print("pindah")
            }
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
    override func viewWillDisappear(_ animated: Bool) {
        let tab = tabBarController as! TabbarViewController
        tab.restoran = restaurantData.restoranarray
    }
    

    
  


}
