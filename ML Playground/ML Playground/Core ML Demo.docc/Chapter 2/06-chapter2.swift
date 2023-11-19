import UIKit
import Vision
import CoreML

class ImageClassifier {
    
    static let model = setupModel()
    
    static func setupModel() -> VNCoreMLModel {
        
        let config = MLModelConfiguration()
        config.computeUnits = MLComputeUnits.cpuAndGPU
        
        let squeezeNet = try? SqueezeNet(
            configuration: config
        )
        
        guard let squeezeNet = squeezeNet else {
            fatalError("App failed to create a model instance.")
        }
        
        let underlyingModel = squeezeNet.model
        
        guard let visionModel = try? VNCoreMLModel(
            for: underlyingModel
        ) else {
            fatalError("App failed to create a `VNCoreMLModel` instance.")
        }
        
        return visionModel
        
    }
    
}
