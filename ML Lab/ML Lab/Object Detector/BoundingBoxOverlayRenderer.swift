//
//  BoundingBoxOverlayRenderer.swift
//  ML Playground
//
//  Created by Lennart Fischer on 03.11.23.
//

import SwiftUI
import Vision

struct BoundingBoxOverlayRenderer: View {
    
    var items: [ObjectDetectorItem]
    
    private let horizontalPadding: Double = 4
    
    var numberedItems: [ObjectDetectorItem] {
        return items.enumerated().map { (index, item) in
            return .init(
                text: "\(item.text) (\(index + 1))",
                percentage: item.percentage,
                boundingBox: item.boundingBox
            )
        }
    }
    
    var body: some View {
        
        Canvas { context, size in
            
            for item in items {
                
                let imageRect = VNImageRectForNormalizedRect(
                    item.boundingBox, Int(size.width), Int(size.height)
                )
                
                let resolved = context.resolve(Text(item.text).font(.caption))
                let flippedBoundingBox = CGRect(
                    x: imageRect.minX,
                    y: size.height - imageRect.maxY,
                    width: imageRect.width,
                    height: imageRect.height
                )
                
                context.stroke(
                    Path(
                        roundedRect: flippedBoundingBox,
                        cornerRadius: 5
                    ),
                    with: .color(.yellow),
                    lineWidth: 2
                )
                
                let width = resolved.measure(in: size)
                    .width
                
                let height = resolved.measure(in: size)
                    .height
                
                context.fill(
                    Path(
                        roundedRect: CGRect(
                            x: imageRect.minX,
                            y: size.height - imageRect.maxY - height,
                            width: width + 2 * horizontalPadding,
                            height: height
                        ),
                        cornerRadius: 2
                    ),
                    with: .color(.yellow)
                )
                
                context.draw(
                    resolved,
                    at: CGPoint(x: imageRect.minX + horizontalPadding, y: size.height - imageRect.maxY),
                    anchor: .bottomLeading
                )
                
            }
            
        }
        
    }
    
}

#Preview {
    BoundingBoxOverlayRenderer(items: [])
}
