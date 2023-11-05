//
//  Double+Extensions.swift
//  ML Playground
//
//  Created by Lennart Fischer on 02.11.23.
//

import Foundation

public extension Double {
    
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
