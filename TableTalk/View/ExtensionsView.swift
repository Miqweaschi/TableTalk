//
//  ExtensionColor.swift
//  TableTalk
//
//  Created by AFP PAR 14 on 05/12/25.
//

import Foundation
import SwiftUI

extension Color {
    init(r : Double , g: Double, b: Double, opacity : Double){
        
        self.init(
            .sRGB,
            red: r/255.0,
            green: g/255.0,
            blue: b/255.0,
            opacity: opacity
        )
        
    }
}

extension MainHomeView {
    
    func monthYearString(from date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: date)
    }
}
