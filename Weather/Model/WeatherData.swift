//
//  WeatherData.swift
//  Weather
//
//  Created by ahmet on 26.09.2020.
//  Copyright © 2020 ahmetguvez. All rights reserved.
//

import Foundation

struct WheatherData : Decodable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}
struct Clouds : Decodable{
    let all: Int?
}

// MARK: - Coord
struct Coord : Decodable{
    let lon, lat: Double?
}

// MARK: - Main
struct Main : Decodable{
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?
}

// MARK: - Sys
struct Sys : Decodable{
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - Weather
struct Weather : Decodable{
    let id: Int?
    let main, weatherDescription, icon: String?
}

// MARK: - Wind
struct Wind : Decodable{
    let speed: Double?
    let deg: Int?
}
