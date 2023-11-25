//
//  ImagePredictor.swift
//  ML Lab
//
//  Created by Lennart Fischer on 02.11.23.
//

import Vision
import UIKit

/// The function signature the caller must provide as a completion handler.
typealias ImageClassificationHandler = (_ predictions: [ImageClassificationPredication]?) -> Void

/// A convenience class that makes image classification predictions.
///
/// The Image Predictor creates and reuses an instance of a Core ML image classifier inside a ``Vision/VNCoreMLRequest``.
/// Each time it makes a prediction, the class:
/// - Creates a `VNImageRequestHandler` with an image
/// - Starts an image classification request for that image
/// - Converts the prediction results in a completion handler
/// - Updates the delegate's `predictions` property
/// - Tag: ImagePredictor
class ImagePredictor {
    
    /// - Tag: name
    static func setupWrapper(with configuration: MLModelConfiguration, for model: AppModel) -> MLModel {
        
        switch model {
            case .squeezeNet:
                
                let squeezeNet = try? SqueezeNet(configuration: configuration)
                
                guard let squeezeNet = squeezeNet else {
                    fatalError("App failed to create an image classifier model instance.")
                }
                
                return squeezeNet.model
                
            case .catsAndDogs:
                
                let catsAndDogs = try? Cats_and_Dogs(configuration: configuration)
                
                guard let catsAndDogs = catsAndDogs else {
                    fatalError("App failed to create an image classifier model instance.")
                }
                
                return catsAndDogs.model
                
            default:
                fatalError("This model is not implemented yet.")
        }
        
    }
    
    private static func setupModel(model: AppModel) -> VNCoreMLModel {
        
        // Use a default model configuration.
        let defaultConfig = MLModelConfiguration()
        
        // Get the underlying model instance.
        let model = setupWrapper(with: defaultConfig, for: model)
        
        // Create a Vision instance using the image classifier's model instance.
        guard let visionModel = try? VNCoreMLModel(for: model) else {
            fatalError("App failed to create a `VNCoreMLModel` instance.")
        }
        
        return visionModel
        
    }
    
    private let model: VNCoreMLModel
    
    public init(model: AppModel) {
        
        switch model {
            case .catsAndDogs:
                self.model = Self.setupModel(model: model)
            case .squeezeNet:
                self.model = Self.setupModel(model: model)
            default: fatalError("This model is not implemented yet.")
        }
        
    }
    
    /// A dictionary of prediction handler functions, each keyed by its Vision request.
    private var predictionHandlers = [VNRequest: ImageClassificationHandler]()
    
    /// Generates a new request instance that uses the underlying image classifier model.
    private func createImageClassificationRequest() -> VNCoreMLRequest {
        // Create an image classification request with an image classifier model.
        
        let imageClassificationRequest = VNCoreMLRequest(
            model: self.model,
            completionHandler: visionRequestHandler
        )
        
        imageClassificationRequest.imageCropAndScaleOption = .centerCrop
        
        return imageClassificationRequest
    }
    
    /// Generates an image classification prediction for a photo.
    /// - Parameter photo: An image, typically of an object or a scene.
    /// - Tag: makePredictions
    func makePredictions(for photo: UIImage, completionHandler: @escaping ImageClassificationHandler) throws {
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
        
        let requests: [VNRequest] = [imageClassificationRequest]
        
        // Start the image classification request.
        try handler.perform(requests)
    }
    
    /// The completion handler method that Vision calls when it completes a request.
    /// - Parameters:
    ///   - request: A Vision request.
    ///   - error: An error if the request produced an error; otherwise `nil`.
    ///
    ///   The method checks for errors and validates the request's results.
    /// - Tag: visionRequestHandler
    private func visionRequestHandler(_ request: VNRequest, error: Error?) {
        // Remove the caller's handler from the dictionary and keep a reference to it.
        guard let predictionHandler = predictionHandlers.removeValue(forKey: request) else {
            fatalError("Every request must have a prediction handler.")
        }
        
        // Start with a `nil` value in case there's a problem.
        var predictions: [ImageClassificationPredication]? = nil
        
        // Call the client's completion handler after the method returns.
        defer {
            // Send the predictions back to the client.
            predictionHandler(predictions)
        }
        
        // Check for an error first.
        if let error = error {
            print("Vision image classification error...\n\n\(error.localizedDescription)")
            return
        }
        
        // Check that the results aren't `nil`.
        if request.results == nil {
            print("Vision request had no results.")
            return
        }
        
        // Cast the request's results as an `VNClassificationObservation` array.
        guard let observations = request.results as? [VNClassificationObservation] else {
            // Image classifiers, like MobileNet, only produce classification observations.
            // However, other Core ML model types can produce other observations.
            // For example, a style transfer model produces `VNPixelBufferObservation` instances.
            print("VNRequest produced the wrong result type: \(type(of: request.results)).")
            return
        }
        
        // Create a prediction array from the observations.
        predictions = observations.map { observation in
            // Convert each observation into an `ImageClassificationPredication` instance.
            ImageClassificationPredication(
                classification: observation.identifier,
                confidence: observation.confidence,
                confidencePercentage: observation.confidencePercentageString
            )
        }
    }
    
}
