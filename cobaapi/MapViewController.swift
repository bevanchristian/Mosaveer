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

    @IBOutlet var buttonAtas: UIButton!
    @IBOutlet var CenterButton2: UIButton!

    @IBOutlet var pencet: UITabBarItem!
    @IBOutlet var map: MKMapView!
    var locationManager :CLLocationManager!
    var curentLocation = ""
   // let restaurantData = RestaurantData()
    var cordinate = [String]()
    var lat:Double!
    var lng:Double!
    var resto = [restaurant]()
    var nama:String!
    var bintang:String!
    var alamat:String!
    var pin = [Anotate]()
    var pinmasjid = [Anotate]()
    var gambarfinal:UIImage!
    var simpan:FloatMapViewController!
    var lokasifull:String!
    var lokasiUser:String!
    var status:String!
    var deskripsi:String!
    var gambar:[String]!
    var region:MKCoordinateRegion!
    var center : CLLocationCoordinate2D!
    var dataresto = [restaurant]()
    var datamasjid = [restaurant]()
    
    var distancePetunjuk:Double!
    var waktuPetunjuk:TimeInterval!
    var stepPetunjuk = [String]()
    
    
    var sementara:MKOverlay?

    
    
    
    
 
    var fpc:FloatingPanelController!
    var fpc2:FloatingPanelController!
    var fpcmap:FloatingPanelController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // inisiasi floating panel
       
        title = "Map"
       // addTopAndBottomBorders(cell: CenterButton2)
        
        addTopAndBottomBorders(cell: buttonAtas)
        fpc = FloatingPanelController()
        fpc2 = FloatingPanelController()
        fpcmap = FloatingPanelController()
        
        // delegate
        fpc.delegate = self
        map.delegate = self
        // ambil floating panel detail resto
        guard let contentVC = storyboard?.instantiateViewController(identifier: "floatingmap") as? FloatMapViewController else{
            return
        }
        simpan = contentVC
        simpan.ngisi(view: self)
        // di set sebeagai konten nya floating panel
        fpc.set(contentViewController: contentVC)
        
        // untuk desain tampilan floating panel
        let appearance = SurfaceAppearance()
        // Define shadows
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: 16)
        shadow.radius = 12
        shadow.spread = 8
        appearance.shadows = [shadow]
        // Define corner radius and background color
        appearance.cornerRadius = 12.0
        appearance.backgroundColor = .clear
        // Set the new appearance
        fpc.surfaceView.appearance = appearance
        fpc.preferredContentSize = CGSize(width: 100, height: 100)
        fpc.contentMode = .fitToBounds
        // tampilin ke layar
        fpc.addPanel(toParent: self)
        fpc.panGestureRecognizer.isEnabled = false
        UIView.animate(withDuration: 0.25) { [self] in
            fpc.move(to: .hidden, animated: true)
        }

        
        
        
        let tab = tabBarController as? TabbarViewController
       
        if let resto = try? tab?.restoran{
            dataresto = resto
            if resto.count > 0{
            if let a =  try? resto[0].gambarFinal {
                
       
            for x in 0...resto.count-1{
                cordinate.append(contentsOf: resto[x].lokasiMap.components(separatedBy: ","))
                 lat = Double(cordinate[0])
                 lng = Double(cordinate[1])
                let london = Anotate(title: resto[x].nama, subtitle: String(resto[x].rating), coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng),gambarfinal: resto[x].gambarFinal,alamat: resto[x].address,lokasifull: resto[x].lokasiMap,identitas: "resto",statusopen: resto[x].statusOpen,deskripsi: resto[x].deskription,gambar: resto[x].gambar,imageanotate: UIImage(named: "food")!)
                pin.append(london)
                print(london)
                cordinate.removeAll()
             }
            
            map.addAnnotations(pin)
                
            }
            }
        }
        if let resto = try? tab?.masjid{
            datamasjid = resto
            if resto.count > 0{
                
        
            if let a =  try? resto[0].gambarFinal {
            for x in 0...resto.count-1{
                cordinate.append(contentsOf: resto[x].lokasiMap.components(separatedBy: ","))
                 lat = Double(cordinate[0])
                 lng = Double(cordinate[1])
                let masjid = Anotate(title: resto[x].nama, subtitle: String(resto[x].rating), coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng),gambarfinal: resto[x].gambarFinal,alamat: resto[x].address,lokasifull: resto[x].lokasiMap,identitas: "masjid",statusopen: resto[x].statusOpen,deskripsi: resto[x].deskription,gambar: resto[x].gambar,imageanotate: UIImage(named: "masjid")!)
                pinmasjid.append(masjid)
                print(masjid)
                cordinate.removeAll()
             }
    
            map.addAnnotations(pinmasjid)
            }
            }
        }
        map.register(
          ArtworkView.self,
          forAnnotationViewWithReuseIdentifier:
            MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    func addTopAndBottomBorders(cell:UIButton) {
        let thickness: CGFloat = 1
     
       let bottomBorder = CALayer()
       bottomBorder.frame = CGRect(x:0, y: cell.frame.size.height, width: cell.frame.size.width, height:thickness)
        bottomBorder.backgroundColor = UIColor.brown.cgColor
       cell.layer.addSublayer(bottomBorder)
    }
    
    @IBAction func settingAction(_ sender: Any) {
        if sementara != nil{
            map.removeOverlay(sementara!)
        }
        UIView.animate(withDuration: 0.25) { [self] in
            fpc.move(to: .hidden, animated: true)
        }
        if fpcmap != nil{
            UIView.animate(withDuration: 0.25) { [self] in
                fpcmap.move(to: .hidden, animated: true)
            }
        }
       
        if fpc2 != nil{
            UIView.animate(withDuration: 0.25) { [self] in
                fpc2.move(to: .half, animated: true)
            }
        }
      

        
        fpc2.delegate = self
        guard let mapSetting = storyboard?.instantiateViewController(identifier: "setting") as? MapSettingViewController else{
            return
        }
        mapSetting.masjidarray = pinmasjid
        mapSetting.restoarray = pin
        mapSetting.dapetinview(myview:self)
        fpc2.set(contentViewController: mapSetting)
        fpc2.contentMode = .fitToBounds
        fpc2.addPanel(toParent: self)
      //  fpc2.panGestureRecognizer.isEnabled = false
    }
    
    
    @IBAction func recenterAction(_ sender: Any) {
        if sementara != nil{
            UIView.animate(withDuration: 0.5) { [self] in
                map.removeOverlay(sementara!)
            }
     
        }
        if fpcmap != nil{
            UIView.animate(withDuration: 0.25) { [self] in
                fpcmap.move(to: .hidden, animated: true)
            }
        }


        guard let a = center else {return}
        map.setCenter(center, animated: true)
    }
    
    func hideFloatmap(){
        UIView.animate(withDuration: 0.25) {
            self.fpc.move(to: .hidden, animated: true)
        }
        if fpcmap != nil{
            UIView.animate(withDuration: 0.25) { [self] in
                fpcmap.move(to: .half, animated: true)
            }
        }
        guard let petunjuk = storyboard?.instantiateViewController(identifier: "mapJalan") as? PetunjukJalanViewController else{
            return
        }
        fpcmap.delegate = self
        fpcmap.set(contentViewController: petunjuk)
        fpcmap.contentMode = .fitToBounds
        fpcmap.addPanel(toParent: self)
        petunjuk.distanceLabel.text = String(distancePetunjuk) + "Km"
        petunjuk.waktuLabel.text = String(waktuPetunjuk) + "Min"
        petunjuk.petunjuk = stepPetunjuk
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
           let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
           renderer.strokeColor = UIColor.blue
           return renderer
       }
  
    

   /* func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
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
        
    
        //anotationview?.image = UIImage(named: "HADILAU")
        return anotationview
    }*/
    
    
    override func viewDidAppear(_ animated: Bool) {
        determineCurrentLocation()

     
       
    }
    
    
    func masukin(){
        map.addAnnotations(pin)
        map.addAnnotations(pinmasjid)
    }
    func masukinmasjid(){
        map.addAnnotations(pinmasjid)
    }
    func masukinresto(){
        map.addAnnotations(pin)

    }
    // ini cuma dipanggil ketika ada lokasi baru
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // ini dapetin lokasi user
        let userLocation = locations[0] as CLLocation
        // ini untuk nge center kamera
        center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        print(userLocation.coordinate.latitude)
        // ini kotake
        region = MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        map.setRegion(region, animated: true)
        
        let lat = String(userLocation.coordinate.latitude)
        let lng = String(userLocation.coordinate.longitude)
        lokasiUser = lat+","+lng
        
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
            //Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(selesailacak), userInfo: nil, repeats: false)
        
        }
    }
    
    @objc func selesailacak(){
        locationManager.stopUpdatingLocation()
    }

    
 

    /*func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
            return (newCollection.verticalSizeClass == .compact) ? LandscapePanelLayout() : FloatingPanelBottomLayout()
        }*/
    
    
    // jadi method ini ngasih tau anotate maan yang ditekan kepada view
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        // di typecast ke customanotate kita supaya kalo anotate bawaan ga kedetect
        if sementara != nil{
            UIView.animate(withDuration: 0.5) { [self] in
                map.removeOverlay(sementara!)
            }
     
        }
        UIView.animate(withDuration: 0.25) { [self] in
            fpc.move(to: .half, animated: true)
        }
        
        if fpc2 != nil {
            UIView.animate(withDuration: 0.25) { [self] in
                fpc2!.move(to: .hidden, animated: true)
            }
        
        }
        if fpcmap != nil {
            UIView.animate(withDuration: 0.25) { [self] in
                fpcmap!.move(to: .hidden, animated: true)
            }
        
        }
       // fpc.panGestureRecognizer.isEnabled = false
        simpan.ngisi(view: self)
        guard let capital = view.annotation as? Anotate else {return}
        // diambil judul dan simpenann
         nama = capital.title
         bintang = capital.subtitle
        alamat = capital.alamat
        gambarfinal = capital.gambarFinal
        lokasifull = capital.lokasifull
        status = capital.statusopen
        deskripsi = capital.deskripsi
        gambar = capital.gambar
        pindah()
    
        
        print("dipencet anotate")
        
    
    }
    
    
    func pindah() {
        UIView.animate(withDuration: 0.6) {
            self.fpc.move(to: .half, animated: true)
        }
        // simpan itu floating map
        simpan.namaResto.text = nama
        simpan.alamatResto.text = alamat
        simpan.ratingResto.text = bintang
        simpan.gambar.image = gambarfinal
        simpan.lokasi = lokasifull
        simpan.lokasiuser = lokasiUser
        simpan.status = status
        simpan.deskripsi = deskripsi
        simpan.gambarkoleksi = gambar
        simpan.ngisi(view: self)
        //fpc.panGestureRecognizer.isEnabled = false
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

/*class LandscapePanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 69.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
    func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        return [
            surfaceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8.0),
            surfaceView.widthAnchor.constraint(equalToConstant: 291),
        ]
    }
}*/
