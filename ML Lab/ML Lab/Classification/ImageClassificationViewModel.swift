//
//  ImageClassificationViewModel.swift
//  ML Lab
//
//  Created by Lennart Fischer on 02.11.23.
//

import Foundation
import UIKit
import SwiftUI

public struct ImageClassificationResult {
    
    public var label: String?
    public let items: [ImageClassItem]
    
    init(label: String?, items: [ImageClassItem]) {
        self.label = label
        self.items = items
    }
    
}

public class ImageClassificationViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var result: DataState<ImageClassificationResult, Error> = .loading
    
    public var modelInformation: ModelInformation {
        ModelInformation(
            name: model.name,
            description: model.text,
            author: "",
            version: nil
        )
    }
    
    let imagePredictor: ImagePredictor
    
    public var model: AppModel
    
    public init(model: AppModel) {
        self.model = model
        self.imagePredictor = .init(model: model)
    }
    
    public func updateImage(_ image: UIImage) {
        
        DispatchQueue.main.async {
            withAnimation {
                self.image = image
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.classifyImage(image: image)
        }
        
    }
    
    public func classifyImage(image: UIImage) {
        
        do {
            try self.imagePredictor.makePredictions(
                for: image
            ) { predictions in
                
                if let predictions {
                    
                    for prediction in predictions {
                        
                        print("\(prediction.classification): \(prediction.confidence)")
                        
                    }
                    
                } else {
                    print("No result from image predictor.")
                }
                
            }
            
            try self.imagePredictor.makePredictions(
                for: image,
                completionHandler: imagePredictionHandler
            )
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
        
    }
    
    /// The method the Image Predictor calls when its image classifier model generates a prediction.
    /// - Parameter predictions: An array of predictions.
    /// - Tag: imagePredictionHandler
    private func imagePredictionHandler(_ predictions: [ImageClassificationPredication]?) {
        
        DispatchQueue.main.async {
            
            guard let predictions = predictions else {
                
                self.result = .success(ImageClassificationResult(
                    label: "No predictions. (Check console log.)",
                    items: []
                ))
                
                
                return
            }
            
            self.result = .success(ImageClassificationResult(
                label: nil,
                items: Array(predictions.map {
                    ImageClassItem(text: $0.classification, percentage: Double($0.confidence).round(to: 2))
                }.prefix(4))
            ))
            
        }
        
    }
    
}
