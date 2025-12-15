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
            NavigationStack {
                // Con il nuovo modello, argomenti è una lista. Ordiniamo per numero e prendiamo i primi 3.
                let sortedItems = lesson.argomenti.items.sorted { $0.number < $1.number }
                let buttonOne = sortedItems[0]
                let buttonTwo = sortedItems[1]
                let buttonThree = sortedItems[2]
                
                // Bottone 1
                NavigationLink {
                    ArgomentoView(argomento: buttonOne)
                } label: {
                    HStack {
                        Text(buttonOne.number)
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
                    ArgomentoView(argomento: buttonTwo)
                } label: {
                    HStack {
                        Text(buttonTwo.number)
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
                
                // Bottone 3
                NavigationLink {
                    ArgomentoView(argomento: buttonThree)
                } label: {
                    HStack {
                        Text(buttonThree.number)
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
