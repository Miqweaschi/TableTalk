import Foundation
import SwiftUI
import UIKit

struct RoadMapView: View {
    let lesson: Lesson
    
    var body: some View {
        
        ZStack{
            
            
            switch lesson.number{
            case "1":
                Image("RoadMap1").resizable().edgesIgnoringSafeArea(.vertical)
            case "2":
                Image("RoadMap1ok").resizable().edgesIgnoringSafeArea(.vertical)
            default:
                Image("RoadMap2ok").resizable().edgesIgnoringSafeArea(.vertical)
            }
           // Image("RoadMap1").resizable().edgesIgnoringSafeArea(.vertical)
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
                            .padding(51)
                            .font(.system(size: 60))
                    }
                }
                .background(Color(.systemGray5))
                .clipShape(.circle)
                .overlay(
                    Circle()
                        .stroke(
                            Color.init(r: 182, g: 23, b: 45, opacity: 100),
                            style: StrokeStyle(
                                lineWidth: 4,
                                lineCap: .round
                            )
                        )
                )
                .offset(x:-104, y: -28)
                
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
                .overlay(
                    Circle()
                        .stroke(
                            Color.init(r: 182, g: 23, b: 45, opacity: 100),
                            style: StrokeStyle(
                                lineWidth: 4,
                                lineCap: .round
                            )
                        )
                )
                .offset(x: 110, y: 55)
                
                // Bottone 5
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
                .overlay(
                    Circle()
                        .stroke(
                            Color.init(r: 182, g: 23, b: 45, opacity: 100),
                            style: StrokeStyle(
                                lineWidth: 4,
                                lineCap: .round
                            )
                        )
                )
                .offset(x:-110, y: 100)
            }
        }
    }
}
