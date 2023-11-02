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
        
        if let image = viewModel.image {
            
            imageExists(image: image)
            
                
        } else {
            
            ImageClassificationEmptyState(
                onSelectImage: { onAction(.selectPhoto) },
                onTakePicture: { onAction(.takePhoto) }
            )
            
        }
        
    }
    
    @ViewBuilder
    private func imageExists(image: UIImage) -> some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                ImageViewer(image: image)
                
                ImageClassificationInformationView(
                    result: viewModel.result
                )
                
            }
            .padding()
            
        }
        .scrollBounceBehavior(.basedOnSize)
        
    }
    
}

#Preview {
    ImageClassificationScreen(
        viewModel: ImageClassificationViewModel()
    ) { (action: ImageClassificationAction) in
            
    }
}
