import UIKit
import Vision
import CoreML

class ImageClassifier {
    
    static let model = setupModel()
    
    static func setupModel() -> VNCoreMLModel {
        
        let config = MLModelConfiguration()
        config.computeUnits = MLComputeUnits.cpuAndGPU
        
    }
    
}
