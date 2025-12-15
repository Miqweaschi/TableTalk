import Foundation
import SwiftUI
import UIKit

struct RoadMapView: View {
    let lesson: Lesson
    
    var body: some View {
        
        ZStack{
            
            Image("RoadMap1").resizable().edgesIgnoringSafeArea(.vertical)
            NavigationStack {
                
                // Per ogni RoadMap i bottoni saranno sempre 3
                // quindi li creiamo senza il for in modo tale da poter
                // fare lo styling singolarmente
                // E' quindi importante che per ogni lezione ci siano sempre
                // e solo 3 argomenti
                let keys = lesson.argomenti.keys.sorted()
                let buttonOne = lesson.argomenti[keys[0]]
                let buttonTwo = lesson.argomenti[keys[1]]
                let buttonThree = lesson.argomenti[keys[2]]

                // Bottone 1
                NavigationLink {
                    ArgomentoView(arg: buttonOne!)
                } label: {
                    HStack {
                        Text("\(keys[0])")
                            .padding(50)
                            .font(.system(size: 60))
                    }
                }
                .background(Color(.systemGray5))
                .clipShape(.circle)
                
                // Bottone 2
                NavigationLink {
                    ArgomentoView(arg: buttonTwo!)
                } label: {
                    HStack {
                        Text("\(keys[1])")
                            .padding(50)
                            .font(.system(size: 60))
                    }
                }
                .background(Color(.systemGray5))
                .clipShape(.circle)
                .offset(x: 110, y: 47)
                
                // Bottone 3
                NavigationLink {
                    ArgomentoView(arg: buttonThree!)
                } label: {
                    HStack {
                        Text("\(keys[2])")
                            .padding(50)
                            .font(.system(size: 60))
                    }
                }
                .background(Color(.systemGray5))
                .clipShape(.circle)
            }
        }
    }
}
