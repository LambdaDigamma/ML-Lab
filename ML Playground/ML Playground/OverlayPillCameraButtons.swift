//
//  OverlayPillCameraButtons.swift
//  ML Playground
//
//  Created by Lennart Fischer on 21.11.23.
//

import SwiftUI

struct OverlayPillCameraButtons: View {
    
    var onTakePhoto: () -> Void
    var onUseImage: () -> Void
    
    var body: some View {
        
        HStack {
            
            Button(action: { onUseImage() }) {
                
                HStack {
                    Image(systemName: "photo")
                    Text("Select Image")
                }
                .font(.footnote)
                .fontWeight(.semibold)
                .padding(.vertical, 4)
                .padding(.horizontal, 6)
                .frame(maxWidth: .infinity)
                
            }
            .buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .tint(Color.blue)
            
            Button(action: { onTakePhoto() }) {
                
                HStack {
                    Image(systemName: "camera")
                    Text("Take Picture")
                }
                .font(.footnote)
                .fontWeight(.semibold)
                .padding(.vertical, 4)
                .padding(.horizontal, 6)
                .frame(maxWidth: .infinity)
                
            }
            .buttonBorderShape(.capsule)
            .buttonStyle(.bordered)
            .tint(Color.blue)
            
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(Material.bar)
        .clipShape(RoundedRectangle(cornerRadius: 100))
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 6)
        
    }
    
    
    
}

#Preview {
    OverlayPillCameraButtons(onTakePhoto: {}, onUseImage: {})
        .padding()
}
