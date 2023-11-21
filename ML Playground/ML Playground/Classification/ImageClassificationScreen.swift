//
//  ImageClassificationScreen.swift
//  ML Playground
//
//  Created by Lennart Fischer on 02.11.23.
//

import SwiftUI

struct ImageClassificationScreen: View {
    
    @ObservedObject var viewModel: ImageClassificationViewModel
    
    private let onAction: (ImageClassificationAction) -> Void
    
    public init(
        viewModel: ImageClassificationViewModel,
        onAction: @escaping (ImageClassificationAction) -> Void
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
                
                ImageViewer<EmptyView>(image: image)
                
                ImageClassificationInformationView(
                    result: viewModel.result
                )
                
                ModelInformationView(modelInformation: viewModel.modelInformation)
                
            } else {
                
                ImagePlaceholderView(type: .classification)
                
                ModelInformationView(modelInformation: viewModel.modelInformation)
                
            }
            
        }
        
    }
    
}

#Preview {
    ImageClassificationScreen(
        viewModel: ImageClassificationViewModel(model: .squeezeNet)
    ) { (action: ImageClassificationAction) in
            
    }
}
