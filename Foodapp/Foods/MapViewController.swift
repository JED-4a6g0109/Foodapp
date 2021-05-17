//
//  MapViewController.swift
//  Foodapp
//
//  Created by 洪崇恩 on 2020/10/25.
//  Copyright © 2020 洪崇恩. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var MapView: MKMapView!
    let locationManger = CLLocationManager()
    let regionInMeters: Double = 10000
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        

        // Do any additional setup after loading the view.
    }
    func setupLocationManger(){
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManger.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters,
                                                 longitudinalMeters: regionInMeters)
            MapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManger()
            checkLocationAuthorization()
            
        }else{}
    }
    
    func mappin(){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "supermarket"

        // Set the region to an associated map view's region.
        searchRequest.region = MapView.region

        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            
            
            for item in response!.mapItems {
                if let name = item.name,
                    let location = item.placemark.location {
                    print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                    
                    
                    let SupermarketAnnotation = MKPointAnnotation()
                    SupermarketAnnotation.title = name
                    SupermarketAnnotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    SupermarketAnnotation.subtitle = "超市"
                    self.MapView.addAnnotation(SupermarketAnnotation)
                }
            }
        }
        
        
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            MapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManger.startUpdatingLocation()
            mappin()
            break
        case .denied:
            break
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManger(_ manger: CLLocationManager, didUpdateLocations locations:[CLLocation]){
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion.init(center:center, latitudinalMeters:  regionInMeters, longitudinalMeters: regionInMeters)
        MapView.setRegion(region, animated: true)
        }
        
    
    
    func locationManger(_ manger: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        checkLocationAuthorization()
    }
    
}
