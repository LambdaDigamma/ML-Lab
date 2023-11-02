//
//  ImageClassificationViewModel.swift
//  ML Playground
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
    
    public let modelInformation: ModelInformation
    
    let imagePredictor = ImagePredictor()
    
    public init() {
        
        let model = try! SqueezeNet(configuration: .init())
        
        let description = model.model.modelDescription
        
        self.modelInformation = .init(
            name: "SqueezeNet",
            description: description.metadata[.init(rawValue: "MLModelDescriptionKey")] as! String,
            author: (description.metadata[.author] as? String) ?? "",
            version: description.metadata[.versionString] as? String
        )
        
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
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        
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
