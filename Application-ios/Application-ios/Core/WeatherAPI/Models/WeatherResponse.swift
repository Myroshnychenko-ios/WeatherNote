//
//  WeatherResponse.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation

struct WeatherResponse: Decodable {
    
    let weather: [WeatherInfo]
    let main: MainInfo
    let name: String

    struct WeatherInfo: Decodable {
        let description: String
        let icon: String
    }

    struct MainInfo: Decodable {
        let temp: Double
    }
}
