//
//  MLContentView.swift
//  ML Playground
//
//  Created by Lennart Fischer on 21.11.23.
//

import SwiftUI

struct MLContentView<Content: View>: View {
    
    var onTakePhoto: () -> Void
    var onSelectImage: () -> Void
    
    @ViewBuilder
    var content: () -> Content
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                content()
                
            }
            .padding(.bottom, 80)
            .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            
            OverlayPillCameraButtons(
                onTakePhoto: {
                    onTakePhoto()
                },
                onUseImage: {
                    onSelectImage()
                }
            )
            .padding(.horizontal, 8)
            .padding(.vertical)
            
        }
        .scrollBounceBehavior(.basedOnSize)
        
    }
    
    
    
}

#Preview {
    MLContentView(onTakePhoto: {}, onSelectImage: {}) {
        
        Text("Placeholder")
        
    }
}
