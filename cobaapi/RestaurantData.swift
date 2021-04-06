//
//  RestaurantData.swift
//  cobaapi
//
//  Created by bevan christian on 30/03/21.
//
import UIKit
import Foundation

class RestaurantData:Thread {
    var nama : String = ""
    // untuk detail data resto
    var address:String=""
    var crossStreet:String=""
    var lokasiMap :String = ""
    var rating :Double = 0.0
    var deskription:String=""
    var statusOpen :String=""
    var banner :String=""
    var gambar = [String]()
    var veneu:myvenueinfo? = nil
    var mygroupp = [myitems]()
    var gambarFinal:UIImage!
    var foursquare:mygroups? = nil
    var restoranarray = [restaurant]()
    var masjidarray = [restaurant]()
    var count = 0
    let map = MapViewController()
    
    
    
   
    
    func ubah(myView: ViewController,tipe:Int,sudahAda:Bool){
        if tipe == 0 && sudahAda == false{
            let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=KOBFVFCVY1BQZGA30X5ODFA0JKFMZWB0VLF0FCOBE31FUNA1&client_secret=I5BAWA55L23NZC04E1EX3BAS5VXOHNKMKUT5CUVDP4DLX1GD&v=20210324&ll=35.6938,139.7034&categoryId=52e81612bcbc57f1066b79ff&radius=100000&limit=4"
            // diubah jadi url dari string
            if let url = URL(string: urlString) {
                // diparsing
                //print("sss")
                URLSession.shared.dataTask(with: url) { [self] data, response, error in
                  if let data = data {
                    parse(json: data, mainView:myView,mytipe:tipe)
                    // function closure
                  }
               }.resume()
              
            }
        }else if tipe == 1 && sudahAda == false{
            let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=KOBFVFCVY1BQZGA30X5ODFA0JKFMZWB0VLF0FCOBE31FUNA1&client_secret=I5BAWA55L23NZC04E1EX3BAS5VXOHNKMKUT5CUVDP4DLX1GD&v=20210324&ll=35.6938,139.7034&categoryId=4bf58dd8d48988d138941735&radius=100000&limit=3"
            // diubah jadi url dari string
            if let url = URL(string: urlString) {
                // diparsing
                //print("sss")
                URLSession.shared.dataTask(with: url) { [self] data, response, error in
                  if let data = data {
                    parse(json: data, mainView:myView,mytipe:tipe)
                    // function closure
                  }
               }.resume()
              
            }
        } else if tipe == 0 && sudahAda == true{
            DispatchQueue.main.async {
//
                myView.collectionView?.reloadData()
                
            }
        }else if tipe == 1 && sudahAda == true{
            DispatchQueue.main.async {
//
                myView.collectionView?.reloadData()
                
            }
        }
     
        
        
            
                // diparsing
              
            
    }
    
    func ubahfilter(myView: ViewController,tipe:Int,sudahAda:Bool,distance:Int,bukak:Int,rating:Int){
        if tipe == 0 && sudahAda == false{
            let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=KOBFVFCVY1BQZGA30X5ODFA0JKFMZWB0VLF0FCOBE31FUNA1&client_secret=I5BAWA55L23NZC04E1EX3BAS5VXOHNKMKUT5CUVDP4DLX1GD&v=20210324&ll=35.6938,139.7034&categoryId=52e81612bcbc57f1066b79ff&radius=\(distance)&limit=5&openNow=\(bukak)&price=\(rating)"
            // diubah jadi url dari string
            if let url = URL(string: urlString) {
                // diparsing
                //print("sss")
                URLSession.shared.dataTask(with: url) { [self] data, response, error in
                  if let data = data {
                    parse(json: data, mainView:myView,mytipe:tipe)
                    // function closure
                  }
               }.resume()
              
            }
            
        }else if tipe == 1 && sudahAda == false{
            let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=KOBFVFCVY1BQZGA30X5ODFA0JKFMZWB0VLF0FCOBE31FUNA1&client_secret=I5BAWA55L23NZC04E1EX3BAS5VXOHNKMKUT5CUVDP4DLX1GD&v=20210324&ll=35.6938,139.7034&categoryId=4bf58dd8d48988d138941735&radius=\(distance)&limit=2&openNow=\(bukak)"
            // diubah jadi url dari string
            if let url = URL(string: urlString) {
                // diparsing
                //print("sss")
                URLSession.shared.dataTask(with: url) { [self] data, response, error in
                  if let data = data {
                    parse(json: data, mainView:myView,mytipe:tipe)
                    // function closure
                  }
               }.resume()
              
            }
        } else if tipe == 0 && sudahAda == true{
            DispatchQueue.main.async {
//
                myView.collectionView?.reloadData()
                
            }
        }else if tipe == 1 && sudahAda == true{
            DispatchQueue.main.async {
//
                myView.collectionView?.reloadData()
                
            }
        }
     
        
        
            
                // diparsing
              
            
    }
    
    
    
    func parse (json:Data, mainView:ViewController,mytipe:Int){
        let decoder = JSONDecoder()
        // di decode
        if let jsonDecoder = try? decoder.decode(foursquares.self, from: json){
            // data hasil e diambil
            foursquare = jsonDecoder.response
            let nested = jsonDecoder.response.groups
            // di ambil karena kan hasile nested
            print("ini data luar")
            print(nested)
            for x in 0...nested.count-1{
               // print(nested[x].items)
                for y in 0...nested[x].items.count-1{
                   // nama resto
                   // bentuk objek
                    var resto = restaurant()
                    resto.id = nested[x].items[y].venue.id
                    let idIsi = resto.id
                    resto.nama = nested[x].items[y].venue.name
                    //idnamaDict[nested[x].items[y].venue.id]=nested[x].items[y].venue.name
                    // addres dulu baru cross street dan dikasih spasi
                    if let crsstreet = nested[x].items[y].venue.location.crossStreet {
                        let addresSementara = nested[x].items[y].venue.location.address + " " + nested[x].items[y].venue.location.crossStreet!
                        resto.address = addresSementara
                    }else{
                        // kalo nill
                        let addresSementara = nested[x].items[y].venue.location.address
                        resto.address = addresSementara
                    }
                    // latitude dan longitude dijadin satu
                    let lat = String(nested[x].items[y].venue.location.lat)
                    let lng = String(nested[x].items[y].venue.location.lng)
                    let lokasi = lat + "," + lng
                    resto.lokasiMap = lokasi
                    print("")
                    print("")
                    print(resto.statusOpen)
                    // setiap sudah selesai ambil id dan nama maka load data detailnya dan dimasukan kedalam objek yang sama
                    let urlcoba = "https://api.foursquare.com/v2/venues/\(resto.id)?&client_id=KOBFVFCVY1BQZGA30X5ODFA0JKFMZWB0VLF0FCOBE31FUNA1&client_secret=I5BAWA55L23NZC04E1EX3BAS5VXOHNKMKUT5CUVDP4DLX1GD&v=20210325"
                    let url = URL(string: urlcoba)
                    if let data4 = try? Data(contentsOf: url!){
                        if let jsonDecoder = try? decoder.decode(detailinfo.self, from: data4){
                            // data hasil e diambil
                            veneu = jsonDecoder.response
                            let nested = jsonDecoder.response.venue
                            // di ambil karena kan hasile nested
                            print("ini detail dalemeee")
                            print(nested)
                            if let ratingisi = nested.rating{
                                resto.rating = ratingisi
                            }else{
                                 resto.rating = 0.0
                            }
                            // ambil deskripsi
                            if let descriptionisi = nested.description{
                                resto.deskription = descriptionisi
                            }else{
                                resto.deskription = "Sorry there is no description"
                            }
                            // ambil jam
                            if let jam = nested.hours?.status {
                                resto.statusOpen = jam
                            }else{
                                resto.statusOpen = "Open Everyday"
                            }
                            if let bannersementara = nested.page?.pageInfo.banner{
                                resto.banner = bannersementara
                            }else{
                                resto.banner = "Kosong"
                            }
                            if nested.tips.groups.count == 0{
                                resto.review.append("Zero review")
                            }else{
                                for t in 0...nested.tips.groups.count-1{
                                    for x in 0...nested.tips.groups[t].items.count-1{
                                        resto.review.append(nested.tips.groups[t].items[x].text)
                                        print("ini review")
                                        print(nested.tips.groups[t].items[x].text)
                                    }
                                }
                            }
                          
                            
                            if let fotoprofil = try? nested.bestPhoto.prefix+"80x80"+nested.bestPhoto.suffix{
                                if let datafoto = try? Data(contentsOf: URL(string: fotoprofil)! ) {
                                    if let foto = UIImage(data: datafoto) {
                                         //self?.foto = foto
                                     resto.gambarFinal = foto
                                        // print(gambarFinal)
                                     print(gambarFinal)
                                    }
                                }}
                            for y in 0...nested.photos.groups.count-1{
                                let detail = nested.photos.groups[y].items
                                for j in 0...detail.count-1{
                                    let prefix = detail[j].prefix
                                    print(prefix)
                                    let suffix = detail[j].suffix
                                    let urlGambar = prefix+"80x80"+suffix
                                    print(urlGambar)
                                    resto.gambar.append(urlGambar)
                                    //load(url: URL(string: urlGambar)!)
                    }}}
                    }
                    
                    // kalo sudah maka objeknya dimasukan dalam array suapya referensi
                    if mytipe == 0{
                        restoranarray.append(resto)
                        print(restoranarray)
                        //map.dataresto = restoranarray
                        
                        // query array of object
                        // closure
                        /*restoranarray.contains { (<#restaurant#>) -> Bool in
                            <#code#>
                       }*/
                    }else if mytipe == 1{
                        masjidarray.append(resto)
                        print(restoranarray)
                    }
                  
            
                }// items count
                
            }//nested count
            // setiap sudah selesai load maka manggil function loaddata untuk reload collectionview
            DispatchQueue.main.async {
//                let main = ViewController()
//                print("reload data")
//                main.collectionView?.reloadData()
                mainView.collectionView?.reloadData()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                    mainView.collectionView?.stopSkeletonAnimation()
                    mainView.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                }
                
                
            }
            
        }//parse
        
        
    }//class
    

    
    
    

   /* func getResto()-> [restaurant] {
        
        let restoranArray=[restaurant]()
            let resto=restaurant()
            resto.id = id
            resto.address = address
            resto.banner = banner
            resto.crossStreet = crossStreet
            resto.deskription = deskription
            resto.gambar = gambar
            resto.gambarFinal = gambarFinal
            resto.lokasiMap = lokasiMap
            resto.nama = nama
            resto.rating = rating
            resto.statusOpen = statusOpen
            resto.veneu = veneu
            
        

        return restoranArray
    
        
    }*/
   
}
