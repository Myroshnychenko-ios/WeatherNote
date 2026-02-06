//
//  List + ViewModel.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation
import Combine

extension List {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        @Published var state: State = State()
        
        private let storageService: StorageAPIProtocol
        
        init(dependencies: Dependencies) {
            self.storageService = dependencies.storageService
        }
        
        func send(_ action: Action) {
            switch action {
            case .onAppear:
                state.notes = storageService.fetch()
            case .addButtonTapped:
                state.isPresentedAddNote = true
            case .addNote(let note):
                state.notes.append(note)
                storageService.save(state.notes)
            case .delete(let offsets):
                guard let index = offsets.first else { return }
                state.notes.remove(at: index)
            }
        }
        
        func task(_ action: AsyncAction) async {
        }
    }
}
