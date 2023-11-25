//
//  CGImagePropertyOrientation+Extensions.swift
//  Image Classifier Example
//
//  Created by Lennart Fischer on 19.11.23.
//

import UIKit
import ImageIO

extension CGImagePropertyOrientation {
    
    init(_ orientation: UIImage.Orientation) {
        switch orientation {
            case .up: self = .up
            case .down: self = .down
            case .left: self = .left
            case .right: self = .right
            case .upMirrored: self = .upMirrored
            case .downMirrored: self = .downMirrored
            case .leftMirrored: self = .leftMirrored
            case .rightMirrored: self = .rightMirrored
            @unknown default: self = .up
        }
    }
    
}
