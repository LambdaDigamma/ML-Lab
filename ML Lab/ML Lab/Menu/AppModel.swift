//
//  AppModels.swift
//  ML Lab
//
//  Created by Lennart Fischer on 21.11.23.
//

import Foundation

public enum AppModel: Equatable, Hashable {
    
    case squeezeNet
    case yoloV3
    case catsAndDogs
    
    var name: String {
        switch self {
            case .squeezeNet:
                return "SqueezeNet"
            case .yoloV3:
                return "YOLOv3 Tiny Int8 LUTInput"
            case .catsAndDogs:
                return "Cats and Dogs"
        }
    }
    
    var type: ModelType {
        switch self {
            case .squeezeNet:
                return .classification
            case .yoloV3:
                return .objectDetector
            case .catsAndDogs:
                return .classification
        }
    }
    
    var text: String {
        
        switch self {
            case .squeezeNet:
                return """
                Detects the dominant objects present in an image from a set of 1000 categories such as trees, animals, food, vehicles, person etc. SqueezeNet: AlexNet-level accuracy with 50x fewer parameters https://github.com/DeepScale/SqueezeNet
                """
                
            case .yoloV3:
                return """
                A neural network for fast object detection that detects 80 different classes of objects. Given an RGB image, with the dimensions 416x416, the model outputs two arrays (one for each layer) of arbitrary length; each containing confidence scores for each cell and the normalised coordaintes for the bounding box around the detected object(s). Refer to the original paper for more details. YOLOv3: An Incremental Improvement - https://pjreddie.com/media/files/papers/YOLOv3.pdf
                """

            case .catsAndDogs:
                return """
                Classifies an image as cat or dog. Based on training data from assign3: https://universe.roboflow.com/assign3/assign3-cats-and-dogs
                """
                
        }
        
    }
    
    var author: String {
        
        switch self {
            case .squeezeNet:
                return "Forrest N. Iandola and Song Han and Matthew W. Moskewicz and Khalid Ashraf and William J."
            case .yoloV3:
                return "Joseph Redmon, Ali Farhadi"
            case .catsAndDogs:
                return "Jana Jachkovska, Marvin Speks, Lennart Fischer + Assign3"
        }
        
    }
    
}
