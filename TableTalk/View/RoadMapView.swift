
import Foundation
import SwiftUI
import UIKit

struct RoadMapView: View {
    var body: some View {
        VStack
        {
            Text("RoadMap")
                .font(.largeTitle)
                .padding()
            
            Image("Roadmap")
                .resizable()
                .scaledToFit()

        }
        

    }
}

