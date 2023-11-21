//
//  ImagePlaceholderView.swift
//  ML Playground
//
//  Created by Lennart Fischer on 21.11.23.
//

import SwiftUI

struct ImagePlaceholderView: View {
    
    var type: ModelType
    
    var body: some View {
        
        Rectangle()
            .fill(Color.clear)
            .aspectRatio(1.5, contentMode: .fit)
            .background(Material.ultraThin)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.05), radius: 6)
            .overlay(alignment: .center) {
                
                VStack(spacing: 20) {
                    
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .imageScale(.large)
                        .scaledToFit()
                        .frame(maxWidth: 80)
                        .foregroundStyle(.quaternary, .quinary)
                    
                    Text(prompt)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    
                }
                .frame(maxWidth: 300)
                .padding()
                
            }
        
    }
    
    var prompt: String {
        switch type {
            case .classification:
                return "Please select an image or take a picture to start classifying images."
            case .objectDetector:
                return "Please select an image or take a picture to start detecting objects."
        }
    }
    
}

#Preview {
    
    ZStack {
        
        ImagePlaceholderView(type: .classification)
            .padding()
        
    }
    
}
