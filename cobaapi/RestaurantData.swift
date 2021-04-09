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
    var restoranarraykotor = [restaurant]()

    var masjidarray = [restaurant]()
    var count = 0
    let map = MapViewController()
  
    var restofix = ["Sushiken Asakusa","Tendon Ituki","Gyumon","Soleil","Luxe Burgers","Soup Stock Tokyo Hiroo","Soup Stock Tokyo Shibuya Mark City","Yildiz Turkish Restaurant","Ninja Cafe Asakusa","Habibi Halal Restaurant","Shiibei-Ramen","Samrat-Jiyugaoka","Samrat-Shirokane Takanawa","Samrat Minami Aoyama","Kaenzan Lanzhou Ramen","Nirvanam","Nirvanam Kamiyacho","Indian Restaurant Tandoor","Masala","Sudo","Cafeteria Spice Jaya","Pizzeria Santa FE","Thai Restaurant Siam Orchid Supreme","Indian&Palisha Restaurant Nawab","Annam Indian Restaurant, Ginza","Gonpachi Asakusa Azumabahi","Asian Yakiniku Halal Restaurant","Mazulu Halal Beef Noodle","Halal Sakura","Gyu-kaku Akasaka","Sana Awaji","Masudaen Sohonten","Kebab Stand","The Kebab Factory Asakusa","Maharani South Indian Restaurant","Maharani Indian Restaurant","Maharani Minamisuna Branch","Ayam-YA Shin-Okachimachi","Yoshiya Shinjukuten","Priya","Tsukino Sabaku","Uosho","Oskar Kebab","Jumbo Doner Kebab","Moses’s Kebab","Chicken Man","Veg Kitchen","Sultan Akihabara","Asukusa Umegen","Yakiniku Panga","Sojibou DiverCity Tokyo Plaza","Mrs Istanbul","Ko-so Cafe Biorise","Al Mina","Morocco Tajinya","Uskudar Restaurant","Japanese Restaurant Sakura","Himalaya Curry Shiroganedai Store","Lukla Village Kitasando","Lukla Himalaya Sangu-bashi","Marhaba","Halal Mentai Naritaya Asakusa","Himalaya Curry Sangu-Bashi Store","Himalaya Curry Kitasando Store","Tokyo Muslim Hanten","Harima Kebab Biryani","SilkRoad Tarim Uyghur Restaurant","Restaurant&Bar BolBol","Siddique Shinjyukunishiguc","Siddique Akebonobashiten","Siddique Shinjyukuhyakuninnchoten","Siddique nihonbashihamamatuchou","Siddique Jinbochou","Siddique","Siddique Hanzomon","Siddique Suitengumae","Konya","Palmyra","Torukoazu","Pamukkale","Vege Herb Saga","Samrat Shinjuku","Khana","Malaychan satu","Nasco Food Court","Kaenzan (蘭州拉麺 火焔山)","Halal Wagyu Yakiniku PANGA (ハラール和牛焼肉ぱんが)","halal wagyu yakiniku panga (ハラール和牛焼肉ぱんが)","kaenzan (蘭州拉麺 火焔山)","halima kebab biryani (ハリマ ケバブ ビリヤニ)","nasco food court","palmyra (パルミラ)","chicken man (チキンマン)","khazana (カザーナ)","üsküdar (ウスキュダル)","restaurant aladdin (イランアラブ料理 アラジン)","delhi dining (デリー ダイニング)","marhaba (マルハバ)","bharati (バーラティ)","annam indian restaurant (アナム)","karachi restaurant (カラチの空)","siam orchid supreme (サイアムオーキッド supreme)","falafel brothers","star kebab (スターケバブ アキバテラス)","gyumon (牛門)","sultan (スルターン 秋葉原店)","the kebab factory","malaychan (マレーチャン)","kineya mugimaru (杵屋麦丸)","アラブ地中海料理 神田 al mina","MALAY ASIAN CUISINE 横浜元町店","LUNA HALA (ルナハラ 築地)","Habibi Restaurant (ハビビ レストラン)"]
    

    
    
    
   // 35.7348° N, 139.7077° E
    
    func ubah(myView: ViewController,tipe:Int,sudahAda:Bool){
        if tipe == 0 && sudahAda == false{
            let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=KOBFVFCVY1BQZGA30X5ODFA0JKFMZWB0VLF0FCOBE31FUNA1&client_secret=I5BAWA55L23NZC04E1EX3BAS5VXOHNKMKUT5CUVDP4DLX1GD&v=20210324&ll=35.7348,139.7077&categoryId=52e81612bcbc57f1066b79ff&radius=120000&limit=10"
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
            let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=KOBFVFCVY1BQZGA30X5ODFA0JKFMZWB0VLF0FCOBE31FUNA1&client_secret=I5BAWA55L23NZC04E1EX3BAS5VXOHNKMKUT5CUVDP4DLX1GD&v=20210324&ll=35.7348,139.7077&categoryId=4bf58dd8d48988d138941735&radius=100000&limit=3"
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
            let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=KOBFVFCVY1BQZGA30X5ODFA0JKFMZWB0VLF0FCOBE31FUNA1&client_secret=I5BAWA55L23NZC04E1EX3BAS5VXOHNKMKUT5CUVDP4DLX1GD&v=20210324&ll=35.7348,139.7077&categoryId=52e81612bcbc57f1066b79ff&radius=\(distance)&limit=30&openNow=\(bukak)&price=\(rating)"
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
            let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=KOBFVFCVY1BQZGA30X5ODFA0JKFMZWB0VLF0FCOBE31FUNA1&client_secret=I5BAWA55L23NZC04E1EX3BAS5VXOHNKMKUT5CUVDP4DLX1GD&v=20210324&ll=35.7348,139.7077&categoryId=4bf58dd8d48988d138941735&radius=\(distance)&limit=2&openNow=\(bukak)"
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
    func find(value searchValue: String, in array: [String]) -> Int?
    {
        for (index, value) in array.enumerated()
        {
            if value == searchValue {
                return index
            }
        }

        return nil
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
            //print(nested)
            for x in 0...nested.count-1{
               // print(nested[x].items)
                for y in 0...nested[x].items.count-1{
                   // nama resto
                   // bentuk objek
                    var resto = restaurant()
                    resto.id = nested[x].items[y].venue.id
                    let idIsi = resto.id
                    resto.nama = nested[x].items[y].venue.name
                    
                    let arraylow = restofix.map { $0.lowercased()}
                    if mytipe == 0{
                        let index = find(value:  resto.nama.lowercased(), in: arraylow)
                        if index == nil{
                            continue
                        }
                    }
                   

                    
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
                   // print(resto.statusOpen)
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
                           // print(nested)
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
                                      //  print("ini review")
                                       // print(nested.tips.groups[t].items[x].text)
                                    }
                                }
                            }
                          
                            
                            if let fotoprofil = try? nested.bestPhoto.prefix+"200x200"+nested.bestPhoto.suffix{
                                if let datafoto = try? Data(contentsOf: URL(string: fotoprofil)! ) {
                                    if let foto = UIImage(data: datafoto) {
                                         //self?.foto = foto
                                     resto.gambarFinal = foto
                                        // print(gambarFinal)
                                     //print(gambarFinal)
                                    }
                                }}
                            for y in 0...nested.photos.groups.count-1{
                                let detail = nested.photos.groups[y].items
                                for j in 0...detail.count-1{
                                    let prefix = detail[j].prefix
                                    //print(prefix)
                                    let suffix = detail[j].suffix
                                    let urlGambar = prefix+"200x200"+suffix
                                   // print(urlGambar)
                                    resto.gambar.append(urlGambar)
                                    //load(url: URL(string: urlGambar)!)
                    }}}
                    }
                    
                    // kalo sudah maka objeknya dimasukan dalam array suapya referensi
                    if mytipe == 0{
                      
                        restoranarray.append(resto)
                        // ini untuk filter
                      /*  if restoranarraykotor.count == 2{
                            let arraylow = restofix.map { $0.lowercased()}
                            for x in 0...restoranarraykotor.count-1{
                                if let index = find(value:  restoranarraykotor[x].nama.lowercased(), in: arraylow){
                                    restoranarray.append(restoranarraykotor[x])
                                    print(restoranarraykotor[x].nama)
                                    print("masuk 1 kli cok")
                                    DispatchQueue.main.async {
                                        mainView.collectionView?.reloadData()
                                    }
                                  
                                }}
                        }*/
                       
                      
                        // filtered is ["hello", "world", "this", "list", "strings"]
                        //map.dataresto = restoranarray
                        
                        // query array of object
                        // closure
                    
                    }else if mytipe == 1{
                        masjidarray.append(resto)
                        //print(restoranarray)
                    }
                  
            
                }// items count
                
            }//nested count
            // setiap sudah selesai load maka manggil function loaddata untuk reload collectionview
   
                
                }
         
            DispatchQueue.main.async {
//                let main = ViewController()
//                print("reload data")
//                main.collectionView?.reloadData()
                mainView.collectionView?.reloadData()
                print("reload")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
                    mainView.collectionView?.stopSkeletonAnimation()
                    mainView.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                
                
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
