//
//  MenuItemCellView.swift
//  ML Playground
//
//  Created by Lennart Fischer on 02.11.23.
//

import SwiftUI

public struct MenuItemCellView: View {
    
    private let menuItem: MenuItem
    
    public init(menuItem: MenuItem) {
        self.menuItem = menuItem
    }
    
    public var body: some View {
        
        Rectangle()
            .fill(Color(menuItem.backgroundColor))
            .frame(maxWidth: .infinity, alignment: .leading)
            .aspectRatio(2, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 8)
            .overlay(alignment: .topLeading, content: {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text(menuItem.title)
                        .foregroundStyle(Color(menuItem.foregroundColor))
                        .font(.title2.weight(.bold))
                    
                    Group {
                        if menuItem.type == .classification {
                            Text("\(Image(systemName: "photo.fill.on.rectangle.fill")) Classifier")
                        } else {
                            Text("\(Image(systemName: "dot.viewfinder")) Detector")
                        }
                    }
                    .foregroundStyle(Color(menuItem.foregroundColor))
                    
                    if let description = menuItem.description {
                        
                        Text(description)
                            .foregroundStyle(Color(menuItem.foregroundColor))
                        
                    }
                    
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            })
        
    }
    
}

struct MenuListCellButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .animation(.interactiveSpring, value: 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
        
    }
    
}

#Preview {
    Button(action: {}) {
        MenuItemCellView(
            menuItem: .init(
                id: 1,
                text: "Animal Classification",
                type: .classification,
                backgroundColor: .orange,
                foregroundColor: .white
            )
        )
    }
    .buttonStyle(MenuListCellButtonStyle())
    .padding()
}