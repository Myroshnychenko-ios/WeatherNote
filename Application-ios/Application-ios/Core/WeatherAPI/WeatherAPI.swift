//
//  WeatherAPI.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation

protocol WeatherAPIProtocol {
    
    func getWeather(city: String) async throws -> Weather
}

final class WeatherAPI {

    private let network: NetworkAPIProtocol

    init(network: NetworkAPIProtocol) {
        self.network = network
    }
}

extension WeatherAPI: WeatherAPIProtocol {
    
    // MARK: - Weather API Protocol
    
    func getWeather(city: String) async throws -> Weather {
        let response: WeatherResponse = try await network.request(WeatherEndpoint.current(city: city))
        
        return Weather(
            temperature: response.main.temp,
            description: response.weather.first?.description ?? "N/A",
            icon: response.weather.first?.icon ?? "",
            city: response.name
        )
    }
}
