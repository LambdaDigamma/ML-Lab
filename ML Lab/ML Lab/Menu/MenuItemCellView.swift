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
            .fill(Color(UIColor.systemBackground))
            .frame(maxWidth: .infinity, alignment: .leading)
            .aspectRatio(2, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 6)
            .overlay(alignment: .topLeading, content: {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text(menuItem.title)
                        .foregroundStyle(.primary)
                        .font(.title2.weight(.bold))
                    
                    Group {
                        if menuItem.type == .classification {
                            Text("\(Image(systemName: "photo.fill.on.rectangle.fill")) Classifier")
                        } else {
                            Text("\(Image(systemName: "dot.viewfinder")) Detector")
                        }
                    }
                    .foregroundStyle(Color.secondary)
                    
                    if let description = menuItem.description {
                        
                        Text(description)
                            .foregroundStyle(Color.secondary)
                        
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
                appModel: AppModel.squeezeNet,
                text: AppModel.squeezeNet.text,
                type: AppModel.squeezeNet.type,
                backgroundColor: .white,
                foregroundColor: .black
            )
        )
    }
    .buttonStyle(MenuListCellButtonStyle())
    .padding()
}
