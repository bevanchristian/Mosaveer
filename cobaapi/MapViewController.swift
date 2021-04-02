//
//  MapViewController.swift
//  cobaapi
//
//  Created by bevan christian on 27/03/21.
//

import UIKit
import MapKit
import CoreLocation
import FloatingPanel
class MapViewController: UIViewController ,MKMapViewDelegate,CLLocationManagerDelegate,FloatingPanelControllerDelegate{

    @IBOutlet var pencet: UITabBarItem!
    @IBOutlet var map: MKMapView!
    var locationManager :CLLocationManager!
    var curentLocation = ""
   // let restaurantData = RestaurantData()
    var cordinate = [String]()
    var lat:Double!
    var lng:Double!
    var resto = [restaurant]()
    
    var pin = [Anotate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fpc = FloatingPanelController()
        fpc.delegate = self
        
        guard let contentVC = storyboard?.instantiateViewController(identifier: "floatingmap") as? FloatMapViewController else{
            return
        }
        fpc.set(contentViewController: contentVC)
        let appearance = SurfaceAppearance()

        // Define shadows
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: 16)
        shadow.radius = 40
        shadow.spread = 15
        appearance.shadows = [shadow]

        // Define corner radius and background color
        appearance.cornerRadius = 8.0
        appearance.backgroundColor = .clear

        // Set the new appearance
        fpc.surfaceView.appearance = appearance
        fpc.panGestureRecognizer.isEnabled = false
        UIView.animate(withDuration: 0.25) {
            fpc.move(to: .half, animated: true)
        }
        fpc.addPanel(toParent: self)
       let tab = tabBarController as? TabbarViewController
        resto = tab!.restoran
        for x in 0...resto.count-1{
            cordinate.append(contentsOf: resto[x].lokasiMap.components(separatedBy: ","))
             lat = Double(cordinate[0])
             lng = Double(cordinate[1])
            var london = Anotate(namaResto: resto[x].nama, bintang: String(resto[x].rating), coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng))
            pin.append(london)
            print(london)
            cordinate.removeAll()
         }
        map.addAnnotations(pin)
    }
    
  
    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Anotate else {return nil}
        let identifier = "capital"
        
        // ini untuk reuse karena anotation itu kayak table view
        var anotationview = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        // namun kadang bisa aja tidak ada yang di reuse karena belum diputer map e
        if anotationview == nil{
            //jika kosong maka harus dibuat anotate nya dengan custom anotate yang sudah dibuat jadi pin
            anotationview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //dan karena anotate nya ga ada button kita akan tambahin button untuk nampilin nama kotae
            anotationview?.canShowCallout = true
            // dan setelah callout ditampilin dikasih button aja dengan tipe detaildisclosure
            anotationview?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // untuk button e gausa dikasih target kayak method untuk jalanin kalo setelah dipencet soale yang dipanggil itu calloutaccesorycontrolTapped
        }else{
            // kalo sudah ada ya anotate nya tinggal di update dengan yang baru
            anotationview?.annotation = annotation
        }
        
        return anotationview
    }
    
    override func viewDidAppear(_ animated: Bool) {
        determineCurrentLocation()
     
    }
    // ini cuma dipanggil ketika ada lokasi baru
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // ini dapetin lokasi user
        let userLocation = locations[0] as CLLocation
        // ini untuk nge center kamera
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        print(userLocation.coordinate.latitude)
        // ini kotake
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 100000, longitudinalMeters: 100000)
        map.setRegion(region, animated: true)
        
        
        // masukin pin ke user location
        
        let anotate : MKPointAnnotation = MKPointAnnotation()
        anotate.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        map.addAnnotation(anotate)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // ini request user
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            // method ini untuk mulai nyuruh oke start update location
            locationManager.startUpdatingLocation()
            
        }
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
