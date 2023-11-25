//
//  ImageClassification.swift
//  ML Lab
//
//  Created by Lennart Fischer on 16.11.23.
//

import Foundation
import Vision

/// Stores a classification name and confidence for an image classifier's prediction.
/// - Tag: Prediction
struct ImageClassificationPredication {
    
    /// The name of the object or scene the image classifier recognizes in an image.
    let classification: String
    
    let confidence: VNConfidence
    
    /// The image classifier's confidence as a percentage string.
    ///
    /// The prediction string doesn't include the % symbol in the string.
    let confidencePercentage: String
    
}
