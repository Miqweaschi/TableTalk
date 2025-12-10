//
//  ExtensionColor.swift
//  TableTalk
//
//  Created by AFP PAR 14 on 05/12/25.
//

import Foundation
import SwiftUI
import UIKit

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

extension Image {
    func scaleImage(ratio: Double, imageName: String) -> some View {
        let uiImage = UIImage(named: imageName)!
        
        var size = uiImage.size
        size = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        return self
            .resizable()
            .frame(width: size.width, height: size.height)
    }
}

