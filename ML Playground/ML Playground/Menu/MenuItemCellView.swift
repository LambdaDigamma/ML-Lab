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
                
                VStack(alignment: .leading) {
                    
                    Text(menuItem.title)
                        .foregroundStyle(Color(menuItem.foregroundColor))
                        .font(.title2.weight(.bold))
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
            })

        //        .aspectRatio(1.5, contentMode: .fill)
        //        .background(Color(menuItem.backgroundColor))

        
//        {
//            VStack {
//                
//                Text(menuItem.text)
//                    .foregroundStyle(Color(menuItem.foregroundColor))
//                    .font(.title2.weight(.bold))
//                
//            }
//            Text("ABCDE")
//        }
//        .frame(maxWidth: .infinity)
//        .aspectRatio(1.5, contentMode: .fill)
//        .background(Color(menuItem.backgroundColor))
        
        
//        .padding()
//        .frame(maxWidth: .infinity, alignment: .leading)
//
//        .clipShape(RoundedRectangle(cornerRadius: 12))
//        .shadow(radius: 8)
        
    }
    
}

#Preview {
    MenuItemCellView(menuItem: .init(id: 1, text: "Animal Classification", backgroundColor: .orange, foregroundColor: .white))
        .padding()
}
