//
//  AddNote + ViewModel.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import Foundation
import Combine

extension AddNote {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        @Published var state: State = State()
        
        private let weatherService: WeatherAPIProtocol
        
        private let onComplete: (Note) -> Void
        
        init(dependencies: Dependencies, onComplete: @escaping (Note) -> Void) {
            self.weatherService = dependencies.weatherService
            self.onComplete = onComplete
        }
        
        func send(_ action: Action) {
            switch action {
            case .dismissButtonTapped:
                state.isDismiss = true
            }
        }
        
        func task(_ action: AsyncAction) async {
            switch action {
            case .saveButtonTapped:
                state.isLoading = true
                state.errorText = nil
                
                do {
                    let weather = try await weatherService.getWeather(city: "Kyiv")
                    let note = Note(id: UUID(), text: state.text, date: .now, weather: weather)
                    print(note)
                    onComplete(note)
                    state.isDismiss = true
                } catch {
                    state.errorText = "Couldn't get the weather right now 😕"
                }
                
                state.isLoading = false
            }
        }
    }
}
