import UIKit
import Vision
import CoreML

typealias ImageClassificationHandler = (_ predictions: [ImageClassificationPredication]?) -> Void

class ImageClassifier {
    
    static let model = setupModel()
    
    static func setupModel() -> VNCoreMLModel {}
    
    // MARK: - Request Handling -
    
    private var predictionHandlers = [VNRequest: ImageClassificationHandler]()
    
    
}
