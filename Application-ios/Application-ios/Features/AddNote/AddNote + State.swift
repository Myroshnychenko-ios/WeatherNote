//
//  AddNote + State.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation

extension AddNote {
    
    struct State {
        var isDismiss: Bool = false
        var text: String = ""
        var isLoading: Bool = false
        var errorText: String?
    }
}
