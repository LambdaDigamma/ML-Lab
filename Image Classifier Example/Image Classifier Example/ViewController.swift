//
//  ViewController.swift
//  Image Classifier Example
//
//  Created by Lennart Fischer on 19.11.23.
//

import UIKit

class ViewController: UIViewController {

    let imageClassifier = ImageClassifier()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load an image from Asset Catalogue
        let image = UIImage(named: "example")!
        
        do {
            
            // Make a prediction and print the results.
            try imageClassifier.makePredictions(
                for: image
            ) { predictions in
                
                if let predictions {
                    
                    for prediction in predictions {
                        print("\(prediction.label): \(prediction.confidence)")
                    }
                    
                } else {
                    print("No result from image classifier.")
                }
                
            }
            
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }

    }

}

