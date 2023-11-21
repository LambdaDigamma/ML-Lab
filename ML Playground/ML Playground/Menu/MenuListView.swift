//
//  MenuListView.swift
//  ML Playground
//
//  Created by Lennart Fischer on 03.11.23.
//

import SwiftUI
import CoreML

class MenuListViewModel: ObservableObject {
    
    @Published var items: [MenuItem]
    
    init() {
        
        self.items = [AppModel.squeezeNet, AppModel.catsAndDogs, AppModel.yoloV3]
            .enumerated()
            .map { (index, model) in
                MenuItem(
                    id: index,
                    appModel: model,
                    text: model.name,
                    description: model.text,
                    type: model.type,
                    backgroundColor: .white,
                    foregroundColor: .black
                )
            }
        
    }
    
}


struct MenuListView: View {
    
    @StateObject var viewModel = MenuListViewModel()
    
    let onAction: (MenuItem) -> Void
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack(spacing: 20) {
                
                ForEach(viewModel.items) { item in
                    
                    Button(action: { onAction(item) }) {
                        MenuItemCellView(menuItem: item)
                    }
                    .buttonStyle(MenuListCellButtonStyle())
                    
                }
                
            }
            .padding()
            
        }
        .navigationTitle("ML Playground")
        .navigationBarTitleDisplayMode(.large)
        
    }
    
}

#Preview {
    MenuListView(onAction: { item in })
}
