//
//  ImageViewer.swift
//  ML Playground
//
//  Created by Lennart Fischer on 02.11.23.
//

import SwiftUI

struct ImageViewer: View {
    
    @State var fullscreen = false
    
    var image: UIImage
    
    var body: some View {
        
        ZStack {
            
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            
        }
        .overlay(alignment: .topTrailing, content: {
            
            Button(action: { fullscreen.toggle() }) {
                
                Label("Fullscreen", systemImage: "arrow.down.left.and.arrow.up.right")
                    .labelStyle(.iconOnly)
                    .foregroundStyle(.black)
                    .padding(12)
                    .background(.regularMaterial,
                                in: RoundedRectangle(cornerRadius: 8))
                
            }
            .buttonStyle(OverlayButtonStyle())
            .padding()
            
        })
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Material.thin)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 6)
        .fullScreenCover(isPresented: $fullscreen, content: {
            PhotoViewer(image: image)
        })
        
    }
    
}

#Preview {
    ImageViewer(image: UIImage(named: "redcharlie elephant")!)
        .aspectRatio(1, contentMode: .fit)
}
