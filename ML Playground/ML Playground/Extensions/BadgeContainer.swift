//
//  BadgeContainer.swift
//  ML Playground
//
//  Created by Lennart Fischer on 02.11.23.
//

import SwiftUI

struct BadgeContainer<Content: View>: View {
    
    var name: String
    var backgroundColor: Color = .blue
    var content: () -> Content
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            content()
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Material.thin)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 6)
        .overlay(alignment: .topTrailing) {
            
            VStack {
                Text(name)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(backgroundColor)
                    .clipShape(.capsule)
                    .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.35), radius: 2)
            }
            .padding(.vertical, -16)
            .padding(.horizontal)
            
            
        }
        .padding(.top, 12)
        
    }
    
}

#Preview {
    BadgeContainer(name: "Badge") {
        
        Text("Content goes here")
        
    }
    .padding()
}
