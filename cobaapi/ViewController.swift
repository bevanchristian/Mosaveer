//
//  ViewController.swift
//  cobaapi
//
//  Created by bevan christian on 26/03/21.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet var collectionView: UICollectionView!
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView?.dataSource = self
        collectionView?.delegate = self
        title = "Moosafer"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterOption))
        //tabBarController?.toolbarItems
  
       
        // url nya
       
       
        // dipindah ke beda thread
        DispatchQueue.global(qos: .userInitiated).async {
            let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=A5RPK0BZD2GN3QK2S5C4MSWWQ2SRYYRZ5EJTLI02MFUSUQYL&client_secret=PVP3IWV0Q3V5IDGLDEZPZGRC3AC1U1IIOHJQTMZOX0TQS0ZZ&v=20210324&ll=35.6938,139.7034&categoryId=52e81612bcbc57f1066b79ff&radius=1000&limit=2"
            // diubah jadi url dari string
            if let url = URL(string: urlString) {
                // diparsing
                //print("sss")
                URLSession.shared.dataTask(with: url) { [self] data, response, error in
                  if let data = data {
                     parse(json: data)}
                    //print(data)
                   // print("hello")
                    
                    //untuk ngambil data detail restoran
                    for idIsi in self.id{
                        //print("ssssdefttgf")
                        let urlDetail = "https://api.foursquare.com/v2/venues/\(idIsi)?&client_id=A5RPK0BZD2GN3QK2S5C4MSWWQ2SRYYRZ5EJTLI02MFUSUQYL&client_secret=PVP3IWV0Q3V5IDGLDEZPZGRC3AC1U1IIOHJQTMZOX0TQS0ZZ&v=20210323"
                     
                            // diubah jadi url dari string
                            if let url2 = URL(string: urlDetail) {
                                // diparsing
                                print("iddetail")
                                URLSession.shared.dataTask(with: url2) { [self] data2, response, error in
                                  if let data2 = data2 {
                                     parse2(json: data2)}
                                    //print(data)
                                }.resume()
                              
                            }
                        
                    }
               }.resume()
              
            }
           
         
        }
        
       
        
    }
    // batas ahkir viewdidload
    
    
  
    
    
    @objc func filterOption(){
        // ini code untuk filter nampilin modal
        print("modal")
    }

    // data untuk homepage
    func parse (json:Data){
        let decoder = JSONDecoder()
        // di decode
        if let jsonDecoder = try? decoder.decode(foursquares.self, from: json){
            // data hasil e diambil
            foursquare = jsonDecoder.response
            let nested = jsonDecoder.response.groups
            // di ambil karena kan hasile nested
            //print(nested)
            for x in 0...nested.count-1{
               // print(nested[x].items)
                for y in 0...nested[x].items.count-1{
                   // nama resto
                    nama.append(nested[x].items[y].venue.name)
                    // id resto
                    id.append(nested[x].items[y].venue.id)
                    idnamaDict[nested[x].items[y].venue.id]=nested[x].items[y].venue.name
                    // addres dulu baru cross street dan dikasih spasi
                    if let crsstreet = nested[x].items[y].venue.location.crossStreet {
                        let addresSementara = nested[x].items[y].venue.location.address + " " + nested[x].items[y].venue.location.crossStreet!
                        address.append(addresSementara)
                    }else{
                        // kalo nill
                        let addresSementara = nested[x].items[y].venue.location.address
                        address.append(addresSementara)
                    }
                    
                    // latitude dan longitude dijadin satu
                    let lat = String(nested[x].items[y].venue.location.lat)
                    let lng = String(nested[x].items[y].venue.location.lng)
                    let lokasi = lat + "," + lng
                    lokasiMap.append(lokasi)
                  
                    
                    print("")
                    print("")
                    
                }
            }
            
           // print(foursquare)
         
           
        }
      
        
    }
    
    
    // untuk detail restor
    func parse2(json:Data){
        let decoder = JSONDecoder()
        // di decode
        if let jsonDecoder = try? decoder.decode(detailinfo.self, from: json){
            // data hasil e diambil
            veneu = jsonDecoder.response
            let nested = jsonDecoder.response.venue
            // di ambil karena kan hasile nested
            // ambil rating
            if let ratingisi = nested.rating{
                rating.append(ratingisi)
            }else{
                rating.append(0.0)
            }
            // ambil deskripsi
            if let descriptionisi = nested.description{
                deskription.append(descriptionisi)
            }else{
                deskription.append("kosong")
            }
            // ambil jam
            if let jam = nested.hours?.status {
                statusOpen.append(jam)
            }else{
                statusOpen.append("Open Everyday")
            }
            if let bannersementara = nested.page?.pageInfo.banner{
                banner.append(bannersementara)
            }else{
                banner.append("kosong")
            }
            if let fotoprofil = try? nested.bestPhoto.prefix+"120x150"+nested.bestPhoto.suffix{
                print(fotoprofil)
                print("ini foto profil atas")
                load(url: URL(string: fotoprofil)!)
            }
           

            for y in 0...nested.photos.groups.count-1{
                let detail = nested.photos.groups[y].items
                for j in 0...detail.count-1{
                    let prefix = detail[j].prefix
                    //print(prefix)
                    let suffix = detail[j].suffix
                    let urlGambar = prefix+"120x150"+suffix
                    print(urlGambar)
                    gambar.append(urlGambar)
                    //load(url: URL(string: urlGambar)!)
                }
               
            }
        }
        if gambarFinal.count == nama.count{
            DispatchQueue.main.async{ [self] in
            collectionView.reloadData()
            }
        }
        
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gambarFinal.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "celljson", for: indexPath) as! jsondata
        //let isi = foursquare[indexPath.item].groups
        //print(isi)
        cell.Text.text = nama[indexPath.item]
        //cell.Text.adjustsFontSizeToFitWidth = true
        cell.Text.lineBreakMode = .byWordWrapping
        cell.Text.numberOfLines = 0;
        cell.rating.text = String(rating[indexPath.item])
        cell.foto.image = gambarFinal[indexPath.item]
        cell.openHour.text = statusOpen[indexPath.item]
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
    
    func load(url: URL) {
         
               if let data = try? Data(contentsOf: url) {
                   if let foto = UIImage(data: data) {
                        //self?.foto = foto
                        self.gambarFinal.append(foto)
                       // print(gambarFinal)
                    
                   }
                
               }
      

           
       }
    
    @IBAction func kontrol(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            title = "Food"
            id.removeAll()
            idnamaDict.removeAll()
            nama.removeAll()
            address.removeAll()
            crossStreet.removeAll()
            lokasiMap.removeAll()
            rating.removeAll()
            deskription.removeAll()
            statusOpen.removeAll()
            banner.removeAll()
            mygroupp.removeAll()
            gambar.removeAll()
            gambarFinal.removeAll()
            

            view.backgroundColor = .blue
            // dipindah ke beda thread
            DispatchQueue.global(qos: .userInitiated).async {
                let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=A5RPK0BZD2GN3QK2S5C4MSWWQ2SRYYRZ5EJTLI02MFUSUQYL&client_secret=PVP3IWV0Q3V5IDGLDEZPZGRC3AC1U1IIOHJQTMZOX0TQS0ZZ&v=20210324&ll=35.6938,139.7034&categoryId=52e81612bcbc57f1066b79ff&radius=1000&limit=2"
                // diubah jadi url dari string
                if let url = URL(string: urlString) {
                    // diparsing
                    //print("sss")
                    URLSession.shared.dataTask(with: url) { [self] data, response, error in
                      if let data = data {
                         parse(json: data)}
                        //print(data)
                       // print("makanan")
                        
                        //untuk ngambil data detail restoran
                        for idIsi in self.id{
                            //print("makanan2")
                            let urlDetail = "https://api.foursquare.com/v2/venues/\(idIsi)?&client_id=A5RPK0BZD2GN3QK2S5C4MSWWQ2SRYYRZ5EJTLI02MFUSUQYL&client_secret=PVP3IWV0Q3V5IDGLDEZPZGRC3AC1U1IIOHJQTMZOX0TQS0ZZ&v=20210323"
                         
                                // diubah jadi url dari string
                                if let url2 = URL(string: urlDetail) {
                                    // diparsing
                                    //print("iddetail")
                                    URLSession.shared.dataTask(with: url2) { [self] data2, response, error in
                                      if let data2 = data2 {
                                         parse2(json: data2)}
                                        //print(data)
                                   }.resume()
                                  
                                }
                            
                        }
                   }.resume()
                  
                }
                
             
            }
            
            
        }
        else if sender.selectedSegmentIndex == 1{
            title = "Mosque"
            id.removeAll()
            idnamaDict.removeAll()
            nama.removeAll()
            address.removeAll()
            crossStreet.removeAll()
            lokasiMap.removeAll()
            rating.removeAll()
            deskription.removeAll()
            statusOpen.removeAll()
            banner.removeAll()
            mygroupp.removeAll()
            gambar.removeAll()
            gambarFinal.removeAll()
            view.backgroundColor = .red
            // dipindah ke beda thread
            DispatchQueue.global(qos: .userInitiated).async {
                let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=A5RPK0BZD2GN3QK2S5C4MSWWQ2SRYYRZ5EJTLI02MFUSUQYL&client_secret=PVP3IWV0Q3V5IDGLDEZPZGRC3AC1U1IIOHJQTMZOX0TQS0ZZ&v=20210324&ll=35.6938,139.7034&categoryId=4bf58dd8d48988d138941735&radius=10000&limit=2"
                // diubah jadi url dari string
                if let url = URL(string: urlString) {
                    // diparsing
                    //print("sss")
                    URLSession.shared.dataTask(with: url) { [self] data, response, error in
                      if let data = data {
                         parse(json: data)}
                        //print(data)
                       // print("masjid")
                        
                        //untuk ngambil data detail restoran
                        for idIsi in self.id{
                            //print("masjid2")
                            let urlDetail = "https://api.foursquare.com/v2/venues/\(idIsi)?&client_id=A5RPK0BZD2GN3QK2S5C4MSWWQ2SRYYRZ5EJTLI02MFUSUQYL&client_secret=PVP3IWV0Q3V5IDGLDEZPZGRC3AC1U1IIOHJQTMZOX0TQS0ZZ&v=20210323"
                         
                                // diubah jadi url dari string
                                if let url2 = URL(string: urlDetail) {
                                    // diparsing
                                   // print("iddetail")
                                    URLSession.shared.dataTask(with: url2) { [self] data2, response, error in
                                      if let data2 = data2 {
                                         parse2(json: data2)}
                                        //print(data)
                                   }.resume()
                                  
                                }
                            
                        }
                   }.resume()
                  
                }
                
             
            }
            
        }
        
    }
    
  


}
