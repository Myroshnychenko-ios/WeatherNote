//
//  AddNote + Screen.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import SwiftUI

extension AddNote {
    struct Screen: View {
        
        @Environment(\.dismiss) private var dismiss

        @StateObject private var vm: ViewModel

        init(vm: ViewModel) {
            _vm = StateObject(wrappedValue: vm)
        }

        var body: some View {
            ZStack {
                content()
            }
            .background(Color(.secondarySystemBackground))
            .toolbar {
                toolbar()
            }
            .task {
            }
        }
    }
}

#Preview {
    
    let networkService = NetworkAPI(baseURL: URL(string: Constants.OpenWeather.urlString)!)
    let dependencies = AddNote.Dependencies(weatherService: WeatherAPI(network: networkService))
    let vm = AddNote.ViewModel(dependencies: dependencies, onComplete: { _ in })
    NavigationStack {
        AddNote.Screen(vm: vm)
    }
}

private extension AddNote.Screen {
    
    // MARK: - Toolbar
    
    @ToolbarContentBuilder
    private func toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            dismissButton()
        }
        ToolbarItem(placement: .principal) {
            navigationTitle()
        }
        ToolbarItem(placement: .topBarTrailing) {
            saveButton()
        }
    }
    
    @ViewBuilder
    private func dismissButton() -> some View {
        Button(action: { vm.send(.dismissButtonTapped) }) {
            Label("", systemImage: "xmark")
        }
        .tint(.primary)
        .onChange(of: vm.state.isDismiss) { oldValue, newValue in
            if newValue {
                dismiss()
            }
        }
    }
    
    @ViewBuilder
    private func navigationTitle() -> some View {
        Text("Add Note")
            .font(.title3)
            .fontWeight(.bold)
    }
    
    @ViewBuilder
    private func saveButton() -> some View {
        Button {
            Task {
                await vm.task(.saveButtonTapped)
            }
        } label: {
            if vm.state.isLoading {
                ProgressView()
                    .controlSize(.small)
            } else {
                Text("Save")
            }
        }
        .disabled(vm.state.isLoading || vm.state.text.trimmingCharacters(in: .whitespaces).isEmpty)
    }
}

private extension AddNote.Screen {
    
    // MARK: - Content
    
    @ViewBuilder
    private func content() -> some View {
        VStack(spacing: 16) {
            TextField("Введіть нотатку", text: $vm.state.text, axis: .vertical)
                .lineLimit(3...6)
                .textFieldStyle(.roundedBorder)
            if let errorText = vm.state.errorText {
                Text(errorText)
                    .foregroundStyle(.red)
                    .font(.caption)
            }
            Spacer()
        }
        .padding()
    }
}
