//
//  OverlayButtonStyle.swift
//  ML Playground
//
//  Created by Lennart Fischer on 02.11.23.
//

import SwiftUI

struct OverlayButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label.scaleEffect(configuration.isPressed ? 0.92 : 1.0)
        
    }
    
}

#Preview {
    
    Button(action: { }) {
        
        Label("Close", systemImage: "xmark")
            .labelStyle(.iconOnly)
            .foregroundStyle(.black)
            .padding(12)
            .background(.regularMaterial,
                        in: RoundedRectangle(cornerRadius: 8))
        
    }
    .buttonStyle(OverlayButtonStyle())
    .padding()
    
}
