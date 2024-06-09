//
//  ViewController.swift
//  WeatherForecast
//
//  Created by MAC GNC on 2024/06/03.
//

import CoreLocation
import ReSwift
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate, StoreSubscriber {
    
    let appStore = AppStore(reducer: appRecuder, state: AppState.init(), middleware: [appMiddleware])
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        appStore.subscribe(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        debugPrint("--- weather state: \(state.weatherState) ---")
        debugPrint("--- location state: \(state.locationState) ---")
        
        switch state.weatherState {
            case .loading:
                // TODO: Loading Progress Indicator 배치
                break
                
            case .loaded(let weather):
                if let temp = weather.temperature {
                    temperatureLabel.text = "\(temp)°C"
                }
                break
                
            case .error(let message):
                debugPrint(message)
                break
                
            default:
                break
        }
        
        switch state.locationState {
            case .loading:
                // TODO: Loading Progress Indicator 배치
                break
                
            case .loaded(let location):
                locationLabel.text = location.address
                break
                
            case .error(let message):
                debugPrint(message)
                break
                
            default:
                break
        }
    }

    fileprivate func _setUpLocationManager() {
        locationManager.delegate = self
        
        switch (self.locationManager.authorizationStatus) {
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.requestLocation()
                break
                
            default:
                self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        let (lat, lng) = (userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        debugPrint("coordinates: \(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
        
        // Location Manager가 위경도 좌표를 반환하면 그 좌표를 이용해 행정동을 가져옴
        appStore.dispatch(fetchLocationThunk(lat: lat, lng: lng))
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
