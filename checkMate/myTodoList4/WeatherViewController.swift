//
//  WeatherViewController.swift
//  checkMate
//
//  Created by Annie Vuong on 5/10/17.
//  Copyright © 2017 mySoftVersion. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    var degree: Int!
    var condition: String!
    var imgURL: String!
    var city: String!
    var exists: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let urlRequest = URLRequest(url: URL(string: "https://api.apixu.com/v1/current.json?key=0becdc187c8b440cb3e123625170510&q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))")!)
        
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    
                    if let current = json["current"] as? [String : AnyObject] {
                        
                        if let temp = current["temp_c"] as? Int {
                            self.degree = temp
                        }
                        
                        if let condition = current["condition"] as? [String : AnyObject] {
                            self.condition = condition["text"] as! String
                            let icon = condition["icon"] as! String
                            self.imgURL = "http:\(icon)"
                        }
                    }
                    
                    if let location = json["location"] as? [String : AnyObject] {
                        self.city = location["name"] as! String
                    }
                    
                    if let _ = json["error"] {
                        self.exists = false
                    }
                    
                    DispatchQueue.main.async {
                        if self.exists {
                            self.temperatureLabel.isHidden = false
                            self.conditionLabel.isHidden = false
                            self.weatherIcon.isHidden = false
                            self.temperatureLabel.text = "\(self.degree.description)°C"
                            self.cityNameLabel.text = self.city
                            self.conditionLabel.text = self.condition
                            self.weatherIcon.downloadImage(from: self.imgURL!)
                        } else {
                             self.temperatureLabel.isHidden = true
                             self.conditionLabel.isHidden = true
                             self.weatherIcon.isHidden = true
                             self.cityNameLabel.text = "No matching city found"
                             self.exists = true
                        }
                    }
                    
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
                
            }
        }
        dataTask.resume()
    }
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension UIImageView {
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }
        dataTask.resume()

    }
    
}
