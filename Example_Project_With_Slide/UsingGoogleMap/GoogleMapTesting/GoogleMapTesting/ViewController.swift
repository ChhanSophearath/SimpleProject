//
//  ViewController.swift
//  GoogleMapTesting
//
//  Created by  Rath! on 18/9/23.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    var mapView =  GMSMapView()
    let locationManager = CLLocationManager()
    let marker = GMSMarker()
    
    let lblData = UILabel()
    
    
    lazy var img: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "marker")
        img.contentMode = .scaleAspectFit
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        view.backgroundColor = .white
        
        view.addSubview(lblData)
        lblData.translatesAutoresizingMaskIntoConstraints = false
        lblData.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
        
            lblData.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            lblData.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            lblData.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
        ])
        
        view.addSubview(img)
        img.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -10).isActive = true
        img.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        
        
        
        mapView.delegate = self
        // ... Create mapView as shown above ...
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {

            let latitude = location.coordinate.latitude ;    let longitude = location.coordinate.longitude

            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude ,zoom: 15)

            mapView.camera = camera  // Receive current location
            mapView.isMyLocationEnabled = true  // Enable point current location
            mapView.settings.myLocationButton = true  // Enable button To receive
            mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)   // use for padding myLocationButton
            marker.map = mapView
        }
        locationManager.stopUpdatingLocation()
    }

    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let newPosition = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)  // Calculate
      
        getLocationData(forCoordinate: newPosition) { placemark in
            print("DATA : \(String(describing: placemark))")
            
            let village = placemark?.subLocality ?? "_"
                       let commune = placemark?.locality ?? "_"
                       let district = placemark?.subAdministrativeArea ?? "_"
                       let province = placemark?.administrativeArea ?? "_"
            let street = placemark?.thoroughfare ?? "_"
            
            self.lblData.text =  "Show data ==>: " + "village: " +  village + "," + "commune: " + commune + "," +  "district: " +
            district + "," + "province: " +  province + "," + "street: " + street
             
        }
    }

        //MARK: Get data
        func getLocationData(forCoordinate coordinate: CLLocationCoordinate2D, completion: @escaping (CLPlacemark?) -> Void) {
            let geocoder = CLGeocoder()
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Reverse geocoding error: \(error.localizedDescription)")
                    completion(nil)
                } else if let placemark = placemarks?.first {
                    completion(placemark)
                } else {
                    completion(nil)
                }
            }
        }
}


  
    
    

