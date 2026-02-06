//
//  Note.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
    let date: Date
    let weather: Weather
}
