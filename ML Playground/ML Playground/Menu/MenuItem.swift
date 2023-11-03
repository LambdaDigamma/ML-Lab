//
//  MenuItem.swift
//  ML Playground
//
//  Created by Lennart Fischer on 02.11.23.
//

import Foundation
import UIKit
import CoreML

public struct MenuItem: Hashable, Identifiable {
    
    public let id: Int
    public let title: String
    public let description: String?
    public let backgroundColor: UIColor
    public let foregroundColor: UIColor
    public let type: MenuItemType
    
    public init(
        id: Int,
        text: String,
        description: String? = nil,
        type: MenuItemType,
        backgroundColor: UIColor,
        foregroundColor: UIColor
    ) {
        self.id = id
        self.title = text
        self.description = description
        self.type = type
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

public enum MenuItemType: String {
    case classification = "classification"
    case objectDetector = "objectDetector"
}
