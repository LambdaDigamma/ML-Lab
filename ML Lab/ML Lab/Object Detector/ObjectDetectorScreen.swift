//
//  ObjectDetectorScreen.swift
//  ML Lab
//
//  Created by Lennart Fischer on 03.11.23.
//

import SwiftUI
import Vision

struct ObjectDetectorScreen: View {
    
    @ObservedObject var viewModel: ObjectDetectorViewModel
    
    private let onAction: (ObjectDetectionAction) -> Void
    
    public init(
        viewModel: ObjectDetectorViewModel,
        onAction: @escaping (ObjectDetectionAction) -> Void
    ) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.onAction = onAction
    }
    
    
    var body: some View {
        
        MLContentView(
            onTakePhoto: { onAction(.takePhoto) },
            onSelectImage: { onAction(.selectPhoto) }
        ) {
            
            if let image = viewModel.image {
                
                ImageViewer(image: image) {
                    BoundingBoxOverlayRenderer(items: viewModel.result.value?.items ?? [])
                }
                
                ObjectClassificationInformationView(
                    result: viewModel.result
                )
                
                ModelInformationView(modelInformation: viewModel.modelInformation)
                
            } else {
                
                ImagePlaceholderView(type: .objectDetector)
                
                ModelInformationView(modelInformation: viewModel.modelInformation)
                
            }
            
        }
        
    }
    
}

#Preview {
    ObjectDetectorScreen(viewModel: .init()) { action in
        
    }
}
