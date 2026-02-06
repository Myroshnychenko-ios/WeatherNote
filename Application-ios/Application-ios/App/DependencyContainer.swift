//
//  DependencyContainer.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation
import SwiftUI

class DependencyContainer {
    
    static let shared = DependencyContainer()
    
    private let weatherService: WeatherAPIProtocol
    private let storageService: StorageAPIProtocol
    
    private init() {
        let networkService = NetworkAPI(baseURL: URL(string: Constants.OpenWeather.urlString)!)
        
        self.weatherService = WeatherAPI(network: networkService)
        self.storageService = StorageAPI()
    }
}
