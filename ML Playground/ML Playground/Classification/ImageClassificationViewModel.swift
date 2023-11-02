//
//  ImageClassificationViewModel.swift
//  ML Playground
//
//  Created by Lennart Fischer on 02.11.23.
//

import Foundation
import UIKit
import SwiftUI

public struct ImageClassificationResult {
    
    public let items: [ImageClassItem]
    
    init(items: [ImageClassItem]) {
        self.items = items
    }
    
}

public class ImageClassificationViewModel: ObservableObject {
    
    @Published var image: UIImage?
    
    @Published var result: DataState<ImageClassificationResult, Error> = .loading
    
    public func updateImage(_ image: UIImage) {
        
        DispatchQueue.main.async {
            withAnimation {
                self.image = image
            }
        }
        
    }
    
}
