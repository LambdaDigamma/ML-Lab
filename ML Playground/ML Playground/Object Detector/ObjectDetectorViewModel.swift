//
//  ObjectDetectorViewModel.swift
//  ML Playground
//
//  Created by Lennart Fischer on 03.11.23.
//

import Foundation
import UIKit
import SwiftUI

public struct ObjectDetectorItem: Hashable {
    
    public let text: String
    public let percentage: Double
    public let boundingBox: CGRect
    
    public init(text: String, percentage: Double, boundingBox: CGRect) {
        self.text = text
        self.percentage = percentage
        self.boundingBox = boundingBox
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(text)
        hasher.combine(percentage)
        hasher.combine(boundingBox.width)
        hasher.combine(boundingBox.height)
        hasher.combine(boundingBox.minX)
        hasher.combine(boundingBox.minY)
    }
    
}


public struct ObjectDetectorResult {
    
    public var label: String?
    public let items: [ObjectDetectorItem]
    
    init(label: String?, items: [ObjectDetectorItem]) {
        self.label = label
        self.items = items
    }
    
}

public class ObjectDetectorViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var result: DataState<ObjectDetectorResult, Error> = .loading
    
    public let modelInformation: ModelInformation
    
    let objectDetector = ObjectDetector()
    
    public init() {
        
        let model = try! YOLOv3_Tiny_Int8_LUT(configuration: .init())
        
        let description = model.model.modelDescription
        
        self.modelInformation = .init(
            name: "YOLOv3 Tiny",
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
            try self.objectDetector.makePredictions(
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
    private func imagePredictionHandler(_ predictions: [ObjectDetector.Prediction]?) {
        
        DispatchQueue.main.async {
            
            guard let predictions = predictions else {
                
                self.result = .success(ObjectDetectorResult(
                    label: "No predictions. (Check console log.)",
                    items: []
                ))
                
                
                return
            }
            
            self.result = .success(ObjectDetectorResult(
                label: nil,
                items: predictions.enumerated().map { (index, item) in
                    ObjectDetectorItem(
                        text: "\(item.classification) (\(index + 1))",
                        percentage: Double(item.confidence).round(to: 2),
                        boundingBox: item.boundingBox
                    )
                }
            ))
            
        }
        
    }
    
}
