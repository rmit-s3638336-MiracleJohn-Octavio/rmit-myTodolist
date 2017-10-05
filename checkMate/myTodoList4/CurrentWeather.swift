////
////  CurrentWeather.swift
////  checkMate
////
////  Created by Annie Vuong on 4/10/17.
////  Copyright © 2017 mySoftVersion. All rights reserved.
////
//
//import Foundation
//
//class CurrentWeather {
//    
//    let temperature: Int?
//   
//    let precipProbability: Int?
//    let summary: String?
//    let timezone: String?
//    
//    struct WeatherKeys {
//        static let temperature = "temperature"
//       
//        static let precipProbability = "precipProbability"
//        static let summary = "summary"
//        static let timezone = "timezone"
//    }
//    
//    init(weatherDictionary: [String : Any]) {
//        temperature = weatherDictionary[WeatherKeys.temperature] as? Int
//        
//        
//        if let precipDouble = weatherDictionary[WeatherKeys.precipProbability] as? Double {
//            precipProbability = Int(precipDouble * 100)
//        } else {
//            precipProbability = nil
//        }
//        
//        summary = weatherDictionary[WeatherKeys.summary] as? String
//        timezone = weatherDictionary[WeatherKeys.timezone] as? String
//        
//        
//    }
//    
//    
//}
