//
//  ImageClassificationInformationView.swift
//  ML Playground
//
//  Created by Lennart Fischer on 02.11.23.
//

import SwiftUI

public struct ImageClassItem: Hashable {
    
    public let text: String
    public let percentage: Double
    
    public init(text: String, percentage: Double) {
        self.text = text
        self.percentage = percentage
    }
    
}

struct ImageClassificationInformationView: View {
    
    var result: DataState<ImageClassificationResult, Error>
    
    public init(result: DataState<ImageClassificationResult, Error>) {
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
    
    func placeholderItems() -> [ImageClassItem] {
        
        return [
            ImageClassItem(text: "Pot", percentage: 0.314),
            ImageClassItem(text: "Coral Reef", percentage: 0.184),
            ImageClassItem(text: "Water", percentage: 0.06)
        ]
        
    }
    
}

#Preview("Loading Results") {
    ImageClassificationInformationView(result: .loading)
        .padding()
}

#Preview("Has Results") {
    
    let result = ImageClassificationResult(
        label: nil,
        items: [
            ImageClassItem(text: "Pot", percentage: 0.314),
            ImageClassItem(text: "Coral Reef", percentage: 0.184),
            ImageClassItem(text: "Water", percentage: 0.06)
        ]
    )
    
    return ImageClassificationInformationView(result: .success(result))
        .padding()
}
