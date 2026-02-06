//
//  Endpoint.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}
