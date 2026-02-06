//
//  NetworkError.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decoding(Error)
}
