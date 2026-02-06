//
//  Weather.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation

struct Weather: Codable {
    let temperature: Double
    let description: String
    let icon: String
    let city: String
}
