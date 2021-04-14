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
    
    @IBOutlet var kosong: UILabel!
    
    @IBOutlet var segmentoutlet: UISegmentedControl!
    @IBOutlet var searcbar: UISearchBar!
    
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
       self.navigationController?.setNavigationBarHidden(true, animated: false)
        title = "Browse"
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        self.tabBarController?.tabBar.isHidden = false
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterOption))
        //tabBarController?.toolbarItems
        performSelector(inBackground: #selector(manggildata), with: nil)
        collectionView?.isSkeletonable = true
        collectionView?.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .greenSea), animation: nil, transition: .crossDissolve(0.4))

        if self.collectionView?.contentInset.top == CGFloat(2) {
            searcbar.isHidden = true
        }
            
    
        
    }
    // batas ahkir viewdidload

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            if scrollView == self.collectionView {
                navigationItem.hidesSearchBarWhenScrolling = false
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.hidesBarsWhenVerticallyCompact = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func filterarea(_ sender: Any) {
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
    
    
    
    
    @objc func manggildata() {
        print("mentoring")
        restaurantData.ubah(myView: self,tipe: 0,sudahAda: false)
        restaurantData.ubah(myView: self,tipe: 1,sudahAda: false)
    }
    
  
    
    
    @objc func filterOption(){
        // ini code untuk filter nampilin modal
      
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
            if restaurantData.restoranarray.count == 0{
                kosong.text = "No Data Found..."
            }else{
                kosong.text = ""
            }

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
        navigationItem.hidesSearchBarWhenScrolling = true
        addTopAndBottomBorders(cell: cell)
        if milihapa == 0 {
            
            cell.Text.text = restaurantData.restoranarray[indexPath.item].nama
            print("reload data")
            //cell.Text.adjustsFontSizeToFitWidth = true
            cell.Text.lineBreakMode = .byWordWrapping
            cell.Text.numberOfLines = 0;
            cell.rating.text = String( restaurantData.restoranarray[indexPath.item].rating)
            cell.foto.image = restaurantData.restoranarray[indexPath.item].gambarFinal
            cell.foto.layer.borderWidth = 0
            cell.foto.layer.masksToBounds = true
          //  imagedetail.layer.borderColor = UIColor.ba
            cell.foto.layer.cornerRadius = 10.0
            //This will change with corners of image and height/2 will make this circle shape
            cell.foto.clipsToBounds = true
            cell.openHour.text = restaurantData.restoranarray[indexPath.item].statusOpen
        }else if milihapa == 1{
            cell.Text.text = restaurantData.masjidarray[indexPath.item].nama
            print("reload data")
            //cell.Text.adjustsFontSizeToFitWidth = true
            cell.Text.lineBreakMode = .byWordWrapping
            cell.Text.numberOfLines = 0;
            cell.rating.text = ""
            cell.foto.image = restaurantData.masjidarray[indexPath.item].gambarFinal
            cell.foto.layer.borderWidth = 0
            cell.foto.layer.masksToBounds = true
          //  imagedetail.layer.borderColor = UIColor.ba
            cell.foto.layer.cornerRadius = 10.0
            //This will change with corners of image and height/2 will make this circle shape
            cell.foto.clipsToBounds = true
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
                    detail.lokasi = namaFix.lokasiMap
                    detail.review1 = namaFix.review
                    print(namaFix.gambar)
                    print("INI FOTO APIK")
                    
                    
                   // detail.idresto = id[indexPath.item]
                }
               
                //self.navigationController!.pushViewController(detail, animated: true)
                self.navigationController!.pushViewController(detail, animated: true)
                print("pindah halaman detail")
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
                    detail.lokasi = namaFix.lokasiMap
                    print(namaFix.gambar)
                    print("INI FOTO APIK")
                    
                   // detail.idresto = id[indexPath.item]
                }
               
                self.navigationController?.pushViewController(detail, animated: true)
               // print("pindah")
            }
        }
      
    }
    

    
   @IBAction func kontrol(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            kosong.text = ""
            if restaurantData.restoranarray.isEmpty{
                milihapa = 0
                restaurantData.ubah(myView: self, tipe: 0,sudahAda: false)
            }else{
                milihapa = 0
                restaurantData.ubah(myView: self,tipe: 0,sudahAda: true)
            }
            
        }
        else if sender.selectedSegmentIndex == 1{
            kosong.text = ""
            if restaurantData.masjidarray.isEmpty{
                milihapa = 1
                restaurantData.ubah(myView: self, tipe: 1,sudahAda: false)
            }else{
                milihapa = 1
                restaurantData.ubah(myView: self,tipe: 1,sudahAda: true)
            }
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isScrolling: Bool? = collectionView?.isDragging
        
        if (isScrolling!){
            navigationItem.hidesSearchBarWhenScrolling = false
            searcbar.isHidden = true
        }else{
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let tab = try tabBarController as? TabbarViewController{
            tab.restoran = restaurantData.restoranarray
        }
      
    }
    

    
   


    
}
extension ViewController: UIScrollViewDelegate {
  /*func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == collectionView {
      print("tableview")
        navigationItem.hidesSearchBarWhenScrolling = false
        searcbar.isHidden = true
    }
  }*/
    
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
          print("tableview")
            navigationItem.hidesSearchBarWhenScrolling = false
            searcbar.isHidden = false
        }
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView{
            
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //reach bottom
            searcbar.isHidden = true
            for constraint in self.view.constraints {
                if constraint.identifier == "topatas" {
                   constraint.constant = -45
                }
            }
            segmentoutlet.layoutIfNeeded()
        }

        if (scrollView.contentOffset.y < 0){
            //reach top
        
            searcbar.isHidden = false
            for constraint in self.view.constraints {
                if constraint.identifier == "topatas" {
                   constraint.constant = 0
                }
            }
            segmentoutlet.layoutIfNeeded()
        }

        if (scrollView.contentOffset.y >= 90 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
            //not top and not bottom
            searcbar.isHidden = true
            for constraint in self.view.constraints {
                if constraint.identifier == "topatas" {
                   constraint.constant = -45
                }
            }
            segmentoutlet.layoutIfNeeded()
        }
        }
    }
    
   
}
