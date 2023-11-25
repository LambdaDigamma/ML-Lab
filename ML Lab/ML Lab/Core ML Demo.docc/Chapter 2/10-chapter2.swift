import UIKit
import Vision
import CoreML

typealias ImageClassificationHandler = (_ predictions: [ImageClassificationPredication]?) -> Void

class ImageClassifier {
    
    static let model = setupModel()
    
    static func setupModel() -> VNCoreMLModel {}
    
    // MARK: - Request Handling -
    
    private var predictionHandlers = [VNRequest: ImageClassificationHandler]()
    
    func makePredictions(
        for photo: UIImage,
        completionHandler: @escaping ImageClassificationHandler
    ) throws {
        
        let orientation = CGImagePropertyOrientation(photo.imageOrientation)
        
        guard let photoImage = photo.cgImage else {
            fatalError("Photo doesn't have underlying CGImage.")
        }
        
        let imageClassificationRequest = createImageClassificationRequest()
        
        predictionHandlers[imageClassificationRequest] = completionHandler
        
        let handler = VNImageRequestHandler(
            cgImage: photoImage,
            orientation: orientation
        )
        
        try handler.perform([imageClassificationRequest])
        
    }
    
}
