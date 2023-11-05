//
//  ObjectDetectorScreen.swift
//  ML Playground
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
        
        if let image = viewModel.image {
            
            imageExists(image: image)
            
            
        } else {
            
            PhotoProviderView(
                onSelectImage: { onAction(.selectPhoto) },
                onTakePicture: { onAction(.takePhoto) }
            )
            
        }
        
    }
    
    @ViewBuilder
    private func imageExists(image: UIImage) -> some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                ImageViewer(image: image) {
                    BoundingBoxOverlayRenderer(items: viewModel.result.value?.items ?? [])
                }
                
                ObjectClassificationInformationView(
                    result: viewModel.result
                )
                
                ModelInformationView(modelInformation: viewModel.modelInformation)
                
            }
            .padding()
            
        }
        .scrollBounceBehavior(.basedOnSize)
        
    }
    
}

#Preview {
    ObjectDetectorScreen(viewModel: .init()) { action in
        
    }
}
