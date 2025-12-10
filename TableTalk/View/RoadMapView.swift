
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
            
            List {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
                
            }
            
        }
    }
}

