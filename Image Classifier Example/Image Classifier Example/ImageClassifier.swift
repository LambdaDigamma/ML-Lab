//
//  ImageClassifier.swift
//  Image Classifier Example
//
//  Created by Lennart Fischer on 19.11.23.
//

import UIKit
import Vision
import CoreML

class ImageClassifier {
    
    // MARK: - Setup -
    
    static let model = setupModel()
    
    /// Setup a SqueezeNet model with a default configuration.
    ///
    /// - Returns: a Vision Core ML Molde
    static func setupModel() -> VNCoreMLModel {
        
        let config = MLModelConfiguration()
        
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
    
    // MARK: - Request Handling -
    
    /// Stores all active requests with it's completion handler
    private var predictionHandlers = [VNRequest: ImageClassificationHandler]()
    
    /// Makes a prediction about the classes of the input image and returns the
    /// predictions in the `completionHandler`.
    ///
    /// - Parameters:
    ///   - photo: input image
    ///   - completionHandler: gets called when the image classification finished
    func makePredictions(
        for photo: UIImage,
        completionHandler: @escaping ImageClassificationHandler
    ) throws {
        
        /// Convert the image to a `CGImage`
        let orientation = CGImagePropertyOrientation(photo.imageOrientation)
        
        guard let photoImage = photo.cgImage else {
            fatalError("Photo doesn't have underlying CGImage.")
        }
        
        /// Create an image classification request
        let imageClassificationRequest = createImageClassificationRequest()
        
        /// Store the function called when the request finished in a dictionary
        ///
        /// - `imageClassificationRequest` key
        /// - `completionHandler` value
        predictionHandlers[imageClassificationRequest] = completionHandler
        
        let handler = VNImageRequestHandler(
            cgImage: photoImage,
            orientation: orientation
        )
        
        /// Perform the image request on the input image
        try handler.perform([imageClassificationRequest])
        
    }
    
    /// Creates an image classification request with the SqueezeNet model.
    ///
    /// - Returns: a vision request
    private func createImageClassificationRequest() -> VNCoreMLRequest {
        
        let imageClassificationRequest = VNCoreMLRequest(
            model: Self.model,
            completionHandler: visionRequestFinished
        )
        
        imageClassificationRequest.imageCropAndScaleOption = .centerCrop
        
        return imageClassificationRequest
    }
    
    /// Gets called by the vision request when it finishes.
    /// Can finish with or without an error.
    ///
    /// Calls the completion handler of the request with the prediction results.
    private func visionRequestFinished(for request: VNRequest, with error: Error?) {
        
        // Get the correct completion handler
        guard let predictionHandler = predictionHandlers.removeValue(
            forKey: request
        ) else {
            fatalError("Every request must have a prediction handler.")
        }
        
        // Creates an array of predications
        var predictions: [ImageClassificationPredication]? = nil
        
        // Call the client's completion handler after the method returns.
        defer {
            // Send the predictions back to the client.
            predictionHandler(predictions)
        }
        
        // Check for errors
        if let error = error {
            print("Vision image classification error: \(error.localizedDescription)")
            return
        }
        
        // Check if request has results
        if request.results == nil {
            print("Vision request had no results.")
            return
        }
        
        // Get all classification observations
        guard let observations = request.results as? [VNClassificationObservation] else {
            print("VNRequest produced the wrong result type: \(type(of: request.results)).")
            return
        }
        
        // Map the observations to our `ImageClassificationPredication`
        predictions = observations.map { observation in
            ImageClassificationPredication(
                label: observation.identifier,
                confidence: observation.confidence
            )
        }
        
    }
    
}
