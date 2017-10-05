////
////  CurrentWeatherViewController.swift
////  checkMate
////
////  Created by Annie Vuong on 4/10/17.
////  Copyright © 2017 mySoftVersion. All rights reserved.
////
//
//import UIKit
//
//import CoreLocation
//
//class CurrentWeatherViewController: UIViewController, CLLocationManagerDelegate {
//
//    @IBOutlet weak var cityTextLabel: UILabel!
//    @IBOutlet weak var temperatureLabel: UILabel!
//    @IBOutlet weak var temperatureMetricLabel: UILabel!
//    @IBOutlet weak var backgroundImageView: UIImageView!
//    
//    // Testing Data
//    let forecastAPIKey = "b95bddd0d21f41f9930a9155bd6fd051"
//    var coordinate: (lat: Double, long: Double) = (37.8267,-122.4233)
//    var lat: Double = Double()
//    var long: Double = Double()
//    
//    
//    // Weather manager
//    let manager = CLLocationManager()
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       
//        // Functions to get user location
//        manager.requestAlwaysAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            manager.delegate = self
//            manager.desiredAccuracy = kCLLocationAccuracyBest
//            manager.startUpdatingLocation()
//        }
//        
//    
//        // Functions for displaying weather information
//        let forecastService = ForecastService(APIKey: forecastAPIKey)
//        forecastService.getForecast(latitude: 37.8136, longitude: 144.9631) { (currentWeather) in
//            
//            if let currentWeather = currentWeather {
//                DispatchQueue.main.async {
//                    if let temperature = currentWeather.temperature {
//                        self.temperatureLabel.text = "\(temperature)"
//                    } else {
//                        self.temperatureLabel.text = "-"
//                    }
//                
//                    if let timezone = currentWeather.timezone {
//                        self.cityTextLabel.text = "\(timezone)"
//                    }
//                    else {
//                        self.cityTextLabel.text = "-"
//                    }
//                    
//                }
//            }
//            
//        }
//        // end of functions for displaying weather
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    
//    func  locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations[0]
//        coordinate.lat = location.coordinate.latitude
//        coordinate.long = location.coordinate.longitude
//        lat = location.coordinate.latitude
//        long = location.coordinate.longitude
//        print(lat)
//        print(long)
//        
//    
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if(status == CLAuthorizationStatus.denied) {
//            showLocationDisabledPopUp()
//        }
//    }
//    
//    
//    func showLocationDisabledPopUp() {
//        let alertController = UIAlertController(title: "Background Location Access Disabled.",
//                                                message: "In order to get weather information the app needs your location.",
//                                                preferredStyle: .alert)
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        
//        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
//            if let url = URL(string: UIApplicationOpenSettingsURLString) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//        }
//        
//        alertController.addAction(openAction)
//
//        self.present(alertController, animated: true, completion: nil)
//    }
//    
//    
//}
