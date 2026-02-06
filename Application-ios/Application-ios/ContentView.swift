//
//  ContentView.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 05.02.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .sheet(isPresented: .constant(true)) {
            DependencyContainer.shared.resolveAddNote { note in
                // TODO
            }
        }
    }
}

#Preview {
    ContentView()
}
