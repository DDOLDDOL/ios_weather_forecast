//
//  ViewController.swift
//  WeatherForecast
//
//  Created by MAC GNC on 2024/06/03.
//

import CoreLocation
import ReSwift
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        let (lat, lng) = (userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        debugPrint("coordinates: \(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: Error handling
        debugPrint(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch (manager.authorizationStatus) {
            case .authorizedAlways, .authorizedWhenInUse: // 위치 권한 허가
                manager.desiredAccuracy = kCLLocationAccuracyBest
                manager.requestLocation()
                break
                
            default: // 위치 권한 허가 X
                manager.requestWhenInUseAuthorization()
        }
    }

}
