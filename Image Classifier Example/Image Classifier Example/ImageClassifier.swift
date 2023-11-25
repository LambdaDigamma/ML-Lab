//
//  ImageClassifier.swift
//  Image Classifier Example
//
//  Created by Lennart Fischer on 19.11.23.
//

import UIKit
import Vision
import CoreML

typealias ImageClassificationHandler = (_ predictions: [ImageClassificationPredication]?) -> Void

class ImageClassifier {
    
    // MARK: - Setup -
    
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
        
        guard let observations = request.results as? [VNClassificationObservation] else {
            print("VNRequest produced the wrong result type: \(type(of: request.results)).")
            return
        }
        
        predictions = observations.map { observation in
            ImageClassificationPredication(
                label: observation.identifier,
                confidence: observation.confidence
            )
        }
        
    }
    
}
