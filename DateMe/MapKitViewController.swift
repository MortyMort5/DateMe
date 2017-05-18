//
//  MapKitViewController.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/17/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapKitViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        findLocationOfConnection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.requestAlwaysAuthorization()
    }
    
    //==============================================================
    // MARK: - Properties
    //==============================================================
    let locationManager = CLLocationManager()
    let newPin = MKPointAnnotation()
    weak var delegate: MapKitViewControllerDelegate?
    
    //==============================================================
    // MARK: - IBOutlets
    //==============================================================
    @IBOutlet var locationMapView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    //==============================================================
    // MARK: - IBActions
    //==============================================================
    @IBAction func dismissMapViewButtonTapped(_ sender: Any) {
        //locationManager.stopUpdatingLocation()
        delegate?.mapKitViewControllerSelector(self)
    }
    
    //==============================================================
    // MARK: - Location Functions
    //==============================================================
    func findLocationOfConnection() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        newPin.coordinate = location.coordinate
        mapView.addAnnotation(newPin)
    }
}

protocol MapKitViewControllerDelegate: class {
    func mapKitViewControllerSelector(_ viewController: MapKitViewController)
}
