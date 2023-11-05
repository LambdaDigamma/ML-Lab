//
//  PhotoProviderView.swift
//  ML Playground
//
//  Created by Lennart Fischer on 02.11.23.
//

import SwiftUI

struct PhotoProviderView: View {
    
    var onSelectImage: () -> Void
    var onTakePicture: () -> Void
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image(systemName: "photo.artframe")
                .resizable()
                .imageScale(.large)
                .scaledToFit()
                .frame(maxWidth: 150)
                .foregroundStyle(.tertiary, .secondary)
                .padding(.bottom, 100)
            
            Text("Please select an image or take a picture with your camera.")
                .fontWeight(.medium)
            
            VStack {
                
                Button(action: onSelectImage) {
                    
                    HStack {
                        Image(systemName: "photo")
                        Text("Select Image")
                    }
                        .fontWeight(.semibold)
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    
                }
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(.borderedProminent)
                .tint(Color.blue)
                
                Button(action: onTakePicture) {
                    
                    HStack {
                        Image(systemName: "camera")
                        Text("Take Picture")
                    }
                    .fontWeight(.semibold)
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    
                }
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(.bordered)
                .tint(Color.blue)
                
            }
            .padding(.horizontal)
            
        }
        
    }
    
}

#Preview {
    PhotoProviderView(onSelectImage: {}, onTakePicture: {})
}
