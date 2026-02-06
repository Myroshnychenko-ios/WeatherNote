//
//  List + State.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation

extension List {
    
    struct State {
        var isPresentedAddNote: Bool = false
        var notes: [Note] = []
    }
}
