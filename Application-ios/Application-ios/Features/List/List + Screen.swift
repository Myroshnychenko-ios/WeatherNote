//
//  List + Screen.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 06.02.2026.
//

import SwiftUI

extension List {
    struct Screen: View {

        @StateObject private var vm: ViewModel

        init(vm: ViewModel) {
            _vm = StateObject(wrappedValue: vm)
        }

        var body: some View {
            ZStack {
                content()
            }
            .background(Color(.systemBackground))
            .toolbar {
                toolbar()
            }
            .onAppear {
                vm.send(.onAppear)
            }
            .sheet(isPresented: $vm.state.isPresentedAddNote) {
                NavigationStack {
                    DependencyContainer.shared.resolveAddNote { note in
                        vm.send(.addNote(note))
                    }
                }
            }
        }
    }
}

#Preview {
    
    let dependencies = List.Dependencies(storageService: StorageAPI())
    let vm = List.ViewModel(dependencies: dependencies)
    NavigationStack {
        List.Screen(vm: vm)
    }
}

private extension List.Screen {
    
    // MARK: - Toolbar
    
    @ToolbarContentBuilder
    private func toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            navigationTitle()
        }
        ToolbarItem(placement: .topBarTrailing) {
            addButton()
        }
    }
    
    @ViewBuilder
    private func addButton() -> some View {
        Button(action: { vm.send(.addButtonTapped) }) {
            Label("", systemImage: "plus")
        }
        .tint(.primary)
    }
    
    @ViewBuilder
    private func navigationTitle() -> some View {
        Text("Notes")
            .font(.title3)
            .fontWeight(.bold)
    }
}

private extension List.Screen {
    
    // MARK: - Content
    
    @ViewBuilder
    private func content() -> some View {
        SwiftUI.List {
            if vm.state.notes.isEmpty {
                Section {
                    empty()
                }
                .listRowBackground(Color.clear)
            }
            ForEach(vm.state.notes) { note in
                Section {
                    noteRow(note)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // TODO
                            print("Open details for note:", note.id)
                        }
                }
                
            }
            .onDelete { offsets in
                vm.send(.delete(offsets))
            }
        }
    }
    
    @ViewBuilder
    private func empty() -> some View {
        VStack(spacing: 16) {
            Text("No Data")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
            Text("You have no notes. Add notes to display the list.")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder
    private func noteRow(_ note: Note) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(note.text)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(note.date, style: .time)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(spacing: 4) {
                Text("\(Int(note.weather.temperature))°")
                    .font(.headline)
                AsyncImage(
                    url: URL(
                        string: "https://openweathermap.org/img/wn/\(note.weather.icon)@2x.png"
                    )
                ) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 32, height: 32)
            }
        }
        .padding(.vertical, 4)
    }
}
