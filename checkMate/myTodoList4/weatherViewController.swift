//
//  weatherViewController.swift
//  checkMate
//
//  Created by Miracle John Octavio Jr on 7/10/2017.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit

class weatherViewController: UIViewController, UISearchBarDelegate  {

    @IBOutlet var imgBackground: UIImageView!
    
    @IBOutlet weak var sbrCityName: UISearchBar!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblWeatherCondition: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var imgWeatherIcon: UIImageView!
    
    @IBOutlet weak var aivFetching: UIActivityIndicatorView!
    
    
    // Variables to store data from API
    var _intDegree: Int!
    var _strCondition: String!
    var _strImgURL: String!
    var _strCity: String!
    var _blnExists: Bool = true
    
    // Saved City
    let _strNSUserDefaultKey = "SavedCity"
    var _strSavedCity = "Melbourne"

// MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign Delegate
        sbrCityName.delegate = self
        // sbrCityName.showsCancelButton = true    // This will display Cancel Button
        
        // Insert the Background
        view.insertSubview(imgBackground!, at: 0)
        
        // This will hide the keyboard when top is detected (See extension from MyGlobals)
        self.hideKeyboardWhenTappedAround()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        /*
         
         Note: How to use UserDefault
         
         Save:
         UserDefaults.standard.set(true, forKey: "Key")         //Bool
         UserDefaults.standard.set(1, forKey: "Key")            //Integer
         UserDefaults.standard.set("TEST", forKey: "Key")       //setObject
         
         Retrieve:
         UserDefaults.standard.bool(forKey: "Key")
         UserDefaults.standard.integer(forKey: "Key")
         UserDefaults.standard.string(forKey: "Key")
         
         Delete:
         UserDefaults.standard.removeObject(forKey: "Key")
         
         */
        
        
        // Retrieve City from UserDefault
        if UserDefaults.standard.object(forKey: _strNSUserDefaultKey) != nil {
            _strSavedCity = UserDefaults.standard.string(forKey: _strNSUserDefaultKey)!
        }
        updateWeather(_strSavedCity)
        
    }

// MARK: - Action
    
    // Function called when search bar is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateWeather((searchBar.text!.replacingOccurrences(of: " ", with: "%20")))
        searchBar.text = ""
    }
    
// MARK: - Method
    
    func updateWeather(_ strCityName: String) {
        
        
        /*
         
         Note: JSON Format
         
         {
             "location":
                 {	
                     "name":"Melbourne",
                     "region":"Victoria",
                     "country":"Australia",
                     "lat":-37.82,
                     "lon":144.97,
                     "tz_id":"Australia/Melbourne",
                     "localtime_epoch":1507318379,
                     "localtime":"2017-10-07 6:32"
                 },
         
             "current":
                 {
                     "last_updated_epoch":1507317300,
                     "last_updated":"2017-10-07 06:15",
                     "temp_c":5.0,
                     "temp_f":41.0,
                     "is_day":0,
                     "condition":
                     {
                        "text":"Clear",
                        "icon":"//cdn.apixu.com/weather/64x64/night/113.png",
                        "code":1000
                     },
                     "wind_mph":0.0,
                     "wind_kph":0.0,                // Use This
                     "wind_degree":0,
                     "wind_dir":"N",                // Use This
                     "pressure_mb":1021.0,
                     "pressure_in":30.6,            // Use This
                     "precip_mm":0.0,
                     "precip_in":0.0,               // Use This
                     "humidity":100,
                     "cloud":0,
                     "feelslike_c":5.0,             // Use This
                     "feelslike_f":41.0,
                     "vis_km":10.0,                 // Use This
                     "vis_miles":6.0
                 }
         }
         
         */
        
        // Start Activity Indicator
        self.isHideControls(blnHide: true)
        self.aivFetching.startAnimating()
        
        // URL request with API key and user input in search bar
        let urlRequest = URLRequest(url: URL(string: "https://api.apixu.com/v1/current.json?key=0becdc187c8b440cb3e123625170510&q=\(strCityName)")!)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    
                    // Location
                    
                    if let objLocation = json["location"] as? [String : AnyObject] {
                        // --- City Name
                        self._strCity = objLocation["name"] as! String
                    }
                    
                    // Current
                    
                    if let current = json["current"] as? [String : AnyObject] {
                        // --- Temp
                        if let intTemp = current["temp_c"] as? Int {
                            self._intDegree = intTemp
                        }
                        // --- Condition
                        if let strCondition = current["condition"] as? [String : AnyObject] {
                            self._strCondition = strCondition["text"] as! String
                            // Getting related icon
                            let strIcon = strCondition["icon"] as! String
                            self._strImgURL = "http:\(strIcon)"
                            
                        }
                    }
                    
                    // If user inputs a city name that cannot be found
                    if let _ = json["error"] {
                        self._blnExists = false
                    } else {
                        self._blnExists = true
                        
                        // Save City from UserDefault
                        UserDefaults.standard.set(strCityName, forKey: self._strNSUserDefaultKey)
                    }
                    
                    DispatchQueue.main.async {
                        if self._blnExists {
                            self.isHideControls(blnHide: false)
                            
                            // Set data into fields on view
                            self.lblCityName.text = self._strCity
                            self.imgWeatherIcon.downloadImage(from: self._strImgURL!)
                            self.lblWeatherCondition.text = self._strCondition
                            self.lblTemperature.text = "\(self._intDegree.description)°C"
                            
                            // Stop Activity Indicator
                            self.aivFetching.stopAnimating()
                            
                        } else {
                            // City not found
                            self.isHideControls(blnHide: true)
                            self.lblCityName.isHidden = false
                            self.lblCityName.text = "No matching city found"
                        }
                    }
                    
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            }
        }
        dataTask.resume()
        
    }
    
    func isHideControls(blnHide: Bool) {
        
        self.lblCityName.isHidden = blnHide
        self.imgWeatherIcon.isHidden = blnHide
        self.lblWeatherCondition.isHidden = blnHide
        self.lblTemperature.isHidden = blnHide
        
    }

}

// Used to download icon image from API
extension UIImageView {
    
    /*
     
     Note: Some of the icons will not be downloaded due to 
     security issues. To resolve this, you need to 
     add the following lines on your info.plist
     
     > App Transport Security Settings
        > Allow Arbitrary Loads = YES
     
     */
    
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                    print("Successfully Loaded Icon!")
                }
            } else {
                print("Error Loading Icon!\(error.debugDescription)")
            }
        }
        dataTask.resume()
        
    }
    
}



