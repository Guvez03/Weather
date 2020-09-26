//
//  WeatherModel.swift
//  Weather
//
//  Created by ahmet on 26.09.2020.
//  Copyright © 2020 ahmetguvez. All rights reserved.
//

import Foundation

struct WeatherModel{
    
    let weatherName:String
    let weatherId : Int
    let weatherTemp : Double
    
    var temp : String {
        return String(format: "%0.1f",weatherTemp)
    }

    var ımageId : String {
        switch weatherId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    
}
