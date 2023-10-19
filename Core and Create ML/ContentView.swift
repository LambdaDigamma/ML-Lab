//
//  ContentView.swift
//  Core and Create ML
//
//  Created by Marvin Speks on 19.10.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "camera.aperture")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Core and Create ML!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
