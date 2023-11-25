//
//  ObjectClassificationInformation.swift
//  ML Playground
//
//  Created by Lennart Fischer on 03.11.23.
//

import SwiftUI

struct ObjectClassificationInformationView: View {
    
    var result: DataState<ObjectDetectorResult, Error>
    
    public init(result: DataState<ObjectDetectorResult, Error>) {
        self.result = result
    }
    
    var body: some View {
        
        BadgeContainer(name: "Results") {
            
            Grid(alignment: .trailing, horizontalSpacing: 8, verticalSpacing: 4) {
                ForEach((result.value?.items ?? placeholderItems()), id: \.self) { item in
                    GridRow(alignment: .firstTextBaseline) {
                        
                        VStack(alignment: .leading) {
                            Text(item.percentage, format: .percent)
                                .foregroundStyle(.secondary)
                                .fontWeight(.medium)
                                .monospacedDigit()
                        }
                        
                        Text(item.text)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                }
            }
            .redacted(reason: result.loading ? .placeholder : [])
            
        }
        
    }
    
    func placeholderItems() -> [ObjectDetectorItem] {
        
        return [
            ObjectDetectorItem(text: "Pot", percentage: 0.314, boundingBox: .zero),
            ObjectDetectorItem(text: "Coral Reef", percentage: 0.184, boundingBox: .zero),
            ObjectDetectorItem(text: "Water", percentage: 0.06, boundingBox: .zero)
        ]
        
    }
    
}

//#Preview {
//    ObjectClassificationInformationView()
//}
