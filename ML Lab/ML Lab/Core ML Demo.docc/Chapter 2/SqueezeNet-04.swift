import CoreML


/// Model Prediction Input Type
class SqueezeNetInput : MLFeatureProvider {
    
    /// Input image to be classified as color (kCVPixelFormatType_32BGRA) image buffer, 227 pixels wide by 227 pixels high
    var image: CVPixelBuffer
    
    // ...
    
    init(image: CVPixelBuffer) {
        self.image = image
    }
    
    convenience init(imageWith image: CGImage) throws {
        // ...
    }
    
    convenience init(imageAt image: URL) throws {
        // ...
    }
    
    func setImage(with image: CGImage) throws {
        // ...
    }
    
    func setImage(with image: URL) throws {
        // ...
    }
    
}

/// Model Prediction Output Type
class SqueezeNetOutput : MLFeatureProvider {
    
    /// Source provided by CoreML
    private let provider : MLFeatureProvider
    
    /// Probability of each category as dictionary of strings to doubles
    var classLabelProbs: [String : Double] {
        return self.provider.featureValue(for: "classLabelProbs")!.dictionaryValue as! [String : Double]
    }
    
    // ...
    
}

/// Class for model loading and prediction
class SqueezeNet {
    
    let model: MLModel
    
    // ...
    
    /// Construct a model with configuration
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }
    
    // ...
    
    /// Make a prediction using the structured interface
    func prediction(input: SqueezeNetInput) throws -> SqueezeNetOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }
    
    /// Make a prediction using the structured interface
    func prediction(input: SqueezeNetInput, options: MLPredictionOptions) throws -> SqueezeNetOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return SqueezeNetOutput(features: outFeatures)
    }
    
    // ...
    
}
