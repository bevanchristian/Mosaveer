//
//  DetailViewController.swift
//  cobaapi
//
//  Created by bevan christian on 27/03/21.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIActivityItemSource,MKMapViewDelegate {
 
    
    
   
  
    @IBOutlet var shareOutlet: UIButton!
    
    @IBOutlet var review: UICollectionView!
    @IBOutlet var getDirection: UIButton!
    
   
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
    var lokasiuser = "35.702069,139.775327"
    var lokasi:String!
    var review1:[String] = []
    var yangDiShare = ""
    var mapvew:MapViewController!
    var sementara:MKOverlay?
    
    @IBOutlet var namaRestoran: UILabel!
    
    
    @IBOutlet weak var alamat: UILabel!
    
    @IBOutlet weak var bukajam: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    
    @IBOutlet weak var bintang: UILabel!
    
    
  
    @IBOutlet weak var deskripsi: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        gambar.delegate = self
        gambar.dataSource = self
        review.delegate = self
        review.dataSource = self
        getDirection.layer.cornerRadius = 10
        
        self.view.addSubview(gambar)
        self.view.addSubview(review)
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
        
        if gambarslide!.count > 0{
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
            yangDiShare = String("Mosaveer want to share you halal place you can click the link to get direction to \(nama!)    http://maps.apple.com/?daddr=\(lokasiuser),+CA&saddr=\(String(describing: lokasi!))")
        
          
        
        
        
        
        
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
            return review1.count// diisi review count
        }
      
    }
    
    func isimap(_ view:MapViewController){
        mapvew = view
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func direction(_ sender: Any) {
        // lokasi user kalo default tidak ada
        if lokasiuser == nil{
            lokasiuser = "35.702069,139.775327"
        }
        if mapvew != nil{
        let latandlot = lokasiuser.components(separatedBy: ",")
        let destinasi = lokasi.components(separatedBy: ",")
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(latandlot[0])!, longitude: Double(latandlot[1])!), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(destinasi[0])!, longitude: Double(destinasi[1])!)))
        request.requestsAlternateRoutes = true
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else {return}
            for route in unwrappedResponse.routes{
                if let a = mapvew.sementara{
                    self.mapvew.map.removeOverlay(a)
                }
                self.mapvew.map.addOverlay(route.polyline)
                self.mapvew.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                mapvew.sementara = route.polyline
                for step in route.steps {
                    mapvew.stepPetunjuk.append(step.instructions)
                }
                mapvew.waktuPetunjuk = route.expectedTravelTime/60
                mapvew.distancePetunjuk = route.distance/1000
                
            }
            mapvew.hideFloatmap()
            navigationController?.popViewController(animated: true)
        }
    
 
    
           
        }else{
            
            if let detailmap = storyboard?.instantiateViewController(identifier: "Mapview") as? MapViewController{
                
                let latandlot = lokasiuser.components(separatedBy: ",")
                let destinasi = lokasi.components(separatedBy: ",")
                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(latandlot[0])!, longitude: Double(latandlot[1])!), addressDictionary: nil))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(destinasi[0])!, longitude: Double(destinasi[1])!)))
                request.requestsAlternateRoutes = true
                request.transportType = .walking
                
                let directions = MKDirections(request: request)
                
                directions.calculate { [unowned self] response, error in
                    guard let unwrappedResponse = response else {return}
                    for route in unwrappedResponse.routes{
                        if let a = detailmap.sementara{
                         detailmap.map.removeOverlay(a)
                        }
                       detailmap.map.addOverlay(route.polyline)
                       detailmap.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                        detailmap.sementara = route.polyline
                        for step in route.steps {
                            detailmap.stepPetunjuk.append(step.instructions)
                        }
                        detailmap.waktuPetunjuk = route.expectedTravelTime/60
                        detailmap.distancePetunjuk = route.distance/1000
                        
                    }
                    detailmap.hideFloatmap()
                    //navigationController?.popViewController(animated: true)
                }
               
                  
                
                
                
                  self.navigationController!.pushViewController(detailmap, animated: true)
                  

              }
          /*  DispatchQueue.main.async { [self] in
                  let targetURL = NSURL(string: "http://maps.apple.com/?daddr=\(lokasiuser),+CA&saddr=\(String(describing: lokasi!))")!
                     
                   if UIApplication.shared.canOpenURL(targetURL as URL) != nil{

                       UIApplication.shared.openURL(targetURL as URL)
                   }
                  
              }*/
        }
     
    
    
        
     
        

       
        
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return yangDiShare
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return yangDiShare
    }
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "Mosaveer want to share you a location"
    }
    
    
    @IBAction func shareAction(_ sender: UIButton) {
        let items = [self]
        let share = UIActivityViewController(activityItems: items, applicationActivities: [])
        present(share, animated: true)
    }
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.gambar {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gambarReview", for: indexPath) as! imagedetailCollectionViewCell
            
            cell.imagedetail.layer.borderWidth = 0
            cell.imagedetail.layer.masksToBounds = true
          //  imagedetail.layer.borderColor = UIColor.ba
            cell.imagedetail.layer.cornerRadius = 10.0
            //This will change with corners of image and height/2 will make this circle shape
            cell.imagedetail.clipsToBounds = true
            cell.imagedetail.image = gambarslide1[indexPath.item]
            
            
        return cell
        
       
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "review", for: indexPath) as! reviewDetailCollectionViewCell
            if review1.count != 0{
                cell.reviewplace.text = review1[indexPath.item]
            }else{
                cell.reviewplace.text = "No Review"
            }
           // diisi review
           return cell
        }
    
        
    }
}
