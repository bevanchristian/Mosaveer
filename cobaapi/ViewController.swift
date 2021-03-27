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
    var nama = [String]()
    var idnamaDict = [String:String]()
    var lat = [Double]()
    var address = [String]()
    var ling = [Double]()
    // untuk keperluan parsing pakek tipe data yang sebelume
    var foursquare:mygroups? = nil
    var veneu:myvenueinfo? = nil
    var mygroupp = [myitems]()
    // untuk loading foto resto
    var gambar = [String]()
    var gambarFinal = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        title = "Near Me"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterOption))
        //tabBarController?.toolbarItems
  
       
        // url nya
        let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=KOBFVFCVY1BQZGA30X5ODFA0JKFMZWB0VLF0FCOBE31FUNA1&client_secret=I5BAWA55L23NZC04E1EX3BAS5VXOHNKMKUT5CUVDP4DLX1GD&v=20210324&ll=35.6938,139.7034&categoryId=52e81612bcbc57f1066b79ff&radius=1000&limit=2"
        
       
        // dipindah ke beda thread
        DispatchQueue.global(qos: .userInitiated).async {
            // diubah jadi url dari string
            if let url = URL(string: urlString) {
                // diparsing
                print("sss")
                URLSession.shared.dataTask(with: url) { [self] data, response, error in
                  if let data = data {
                     parse(json: data)}
                    //print(data)
                    print("hello")
                    
                    //untuk ngambil data detail restoran
                    /*for idIsi in self.id{
                        print("ssssdefttgf")
                        let urlDetail = "https://api.foursquare.com/v2/venues/\(idIsi)?&client_id=KOBFVFCVY1BQZGA30X5ODFA0JKFMZWB0VLF0FCOBE31FUNA1&client_secret=I5BAWA55L23NZC04E1EX3BAS5VXOHNKMKUT5CUVDP4DLX1GD&v=20210323"
                     
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
                        
                    }*/
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
                    print(nested[x].items[y].venue.id)
                    print(nested[x].items[y].venue.name)
                    nama.append(nested[x].items[y].venue.name)
                    id.append(nested[x].items[y].venue.id)
                    idnamaDict[nested[x].items[y].venue.id]=nested[x].items[y].venue.name
                    
                    
                   /* let lokasi = nested[x].items[y].venue.location
                    lat.append(lokasi.lat)
                    ling.append(lokasi.lng)
                    address.append(lokasi.address)*/
                    
                    print("")
                    print("")
                    
                }
            }
            
           // print(foursquare)
            DispatchQueue.main.async { [self] in
                collectionView.reloadData()
            }
           
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
            for y in 0...nested.photos.groups.count-1{
                let detail = nested.photos.groups[y].items
                for j in 0...detail.count-1{
                    var prefix = detail[j].prefix
                    print(prefix)
                    var suffix = detail[j].suffix
                    var urlGambar = prefix+"960x720"+suffix
                    print(urlGambar)
                    gambar.append(urlGambar)
                    for u in 0...gambar.count-1{
                        load(url: URL(string:  gambar[u])!  )
                    }
                    //load(url: URL(string: urlGambar)!)
                    
                    
                }
               
            }
            DispatchQueue.main.async { [self] in
                collectionView.reloadData()
            }
            
          
            
           // print(foursquare)
           
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nama.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "celljson", for: indexPath) as! jsondata
        //let isi = foursquare[indexPath.item].groups
        //print(isi)
        cell.Text.text = nama[indexPath.item]
        cell.Text.sizeThatFits(CGSize(width: 180, height: 100))

        //cell.foto.image = gambarFinal[indexPath.item]
        print("masuk0")
       
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
            print("pindah")
        }
    }
    
    func load(url: URL) {
         
               if let data = try? Data(contentsOf: url) {
                   if let foto = UIImage(data: data) {
                        //self?.foto = foto
                        self.gambarFinal.append(foto)
                        print(gambarFinal)
                    
                   }
                
               }
      

           
       }
    
 
    
  

}

