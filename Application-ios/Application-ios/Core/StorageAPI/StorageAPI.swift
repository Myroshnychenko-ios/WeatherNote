//
//  StorageAPI.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation

protocol StorageAPIProtocol {
    
    func save(_ notes: [Note])
    func fetch() -> [Note]
}

final class StorageAPI: StorageAPIProtocol {
    
    func save(_ notes: [Note]) {
        guard let data = try? JSONEncoder().encode(notes) else { return }
        UserDefaults.standard.set(data, forKey: Constants.UserDefaults.notes)
    }
    
    func fetch() -> [Note] {
        guard let data = UserDefaults.standard.data(forKey: Constants.UserDefaults.notes),
              let notes = try? JSONDecoder().decode([Note].self, from: data)
        else {
            return []
        }
        
        return notes
    }
}
