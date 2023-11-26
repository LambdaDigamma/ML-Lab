//
//  ImageClassificationPredication.swift
//  Image Classifier Example
//
//  Created by Lennart Fischer on 19.11.23.
//

import Foundation
import Vision

/// A single output pair of label and it's confidence
struct ImageClassificationPredication {
    
    let label: String
    
    let confidence: VNConfidence
    
}

/// Type for an action which gets executed when predictions where generated
typealias ImageClassificationHandler = (_ predictions: [ImageClassificationPredication]?) -> Void

