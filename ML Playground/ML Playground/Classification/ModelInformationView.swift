//
//  ModelInformationView.swift
//  ML Playground
//
//  Created by Lennart Fischer on 02.11.23.
//

import SwiftUI

public struct ModelInformation {
    
    public let name: String
    public let description: String
    public let author: String
    public let version: String?
    
}

struct ModelInformationView: View {
    
    let modelInformation: ModelInformation
    
    var body: some View {
        
        BadgeContainer(name: "Model", backgroundColor: .orange) {
            
            VStack(alignment: .leading, spacing: 24) {
                
                gridRow(label: "Name", text: modelInformation.name)
                gridRow(label: "Desc", text: modelInformation.description)
                gridRow(label: "Author", text: modelInformation.author)
                
            }
            
        }
        
    }
    
    @ViewBuilder
    private func gridRow(label: String, text: String) -> some View {
        
        VStack(alignment: .leading) {
            
            Text(label)
                .foregroundStyle(.secondary)
//                .fontWeight(.medium)
            
            Text(text)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        
//        GridRow(alignment: .firstTextBaseline) {
//            
//            VStack(alignment: .leading) {
//                Text(label)
//                    .foregroundStyle(.secondary)
//                    .fontWeight(.medium)
//            }
//            
//            Text(text)
//                .fontWeight(.semibold)
//                .frame(maxWidth: .infinity, alignment: .leading)
//            
//        }
        
    }
    
}

#Preview {
    ModelInformationView(
        modelInformation: .init(
            name: "SqueezeNet",
            description: "Detects the dominant objects present in an image from a set of 1000 categories such as trees, animals, food, vehicles, person etc. SqueezeNet: AlexNet-level accuracy with 50x fewer parameters https://github.com/DeepScale/SqueezeNet",
            author: "Forrest N. Iandola and Song Han and Matthew W. Moskewicz and Khalid Ashraf and William J.",
            version: nil
        )
    )
        .padding()
}
