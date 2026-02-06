//
//  WeatherEndpoint.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation

enum WeatherEndpoint: Endpoint {

    case current(city: String)
    case forecast(city: String)

    var path: String {
        switch self {
        case .current:
            return "/data/2.5/weather"
        case .forecast:
            return "/data/2.5/forecast"
        }
    }

    var method: HTTPMethod { .get }

    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = [
            .init(name: "appid", value: Constants.OpenWeather.apiKey),
            .init(name: "units", value: "metric"),
            .init(name: "lang", value: "ua")
        ]

        switch self {
        case .current(let city),
             .forecast(let city):
            items.append(.init(name: "q", value: city))
        }

        return items
    }
}
