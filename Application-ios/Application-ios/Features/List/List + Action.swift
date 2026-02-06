//
//  List + Action.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation

extension List {
    
    enum Action {
        case onAppear
        case addButtonTapped
        case addNote(Note)
        case delete(IndexSet)
    }
    
    enum AsyncAction {
    }
}
