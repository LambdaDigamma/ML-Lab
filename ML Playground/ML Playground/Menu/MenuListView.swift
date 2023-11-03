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
        
        self.items = [
            .init(
                id: 1,
                text: "SqueezeNet",
                description: "Detects the dominant objects present in an image from a set of 1000 categories such as trees, animals, food, vehicles, person etc. SqueezeNet: AlexNet-level accuracy with 50x fewer parameters https://github.com/DeepScale/SqueezeNet",
                type: .classification,
                backgroundColor: .black,
                foregroundColor: .white
            ),
            .init(
                id: 2,
                text: "YOLOv3 Tiny Int8 LUTInput",
                description: "A neural network for fast object detection that detects 80 different classes of objects. Given an RGB image, with the dimensions 416x416, the model outputs two arrays (one for each layer) of arbitrary length; each containing confidence scores for each cell and the normalised coordaintes for the bounding box around the detected object(s). Refer to the original paper for more details. YOLOv3: An Incremental Improvement - https://pjreddie.com/media/files/papers/YOLOv3.pdf",
                type: .objectDetector,
                backgroundColor: .blue,
                foregroundColor: .white
            )
        ]
        
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
