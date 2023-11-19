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
    
    private func createImageClassificationRequest() -> VNCoreMLRequest {
        
        let imageClassificationRequest = VNCoreMLRequest(
            model: Self.model,
            completionHandler: visionRequestHandler
        )
        
        imageClassificationRequest.imageCropAndScaleOption = .centerCrop
        
        return imageClassificationRequest
    }
    
    private func visionRequestHandler(_ request: VNRequest, error: Error?) {
        
        guard let predictionHandler = predictionHandlers.removeValue(
            forKey: request
        ) else {
            fatalError("Every request must have a prediction handler.")
        }
        
        var predictions: [ImageClassificationPredication]? = nil
        
        // Call the client's completion handler after the method returns.
        defer {
            // Send the predictions back to the client.
            predictionHandler(predictions)
        }
        
        if let error = error {
            print("Vision image classification error: \(error.localizedDescription)")
            return
        }
        
        if request.results == nil {
            print("Vision request had no results.")
            return
        }
        
        // ...
        
    }
    
}
