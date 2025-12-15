import Foundation
import SwiftUI
import UIKit

struct RoadMapView: View {
    let lesson: Lesson
    let lessonIndex: Int
    @ObservedObject var model: Model
    
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
                let buttonOne = model.lessonsList[lessonIndex].argomenti.items[0]
                let buttonTwo = sortedItems[1]
                let buttonThree = sortedItems[2]
                
                /// Logica valida per tutti i bottoni (Argomento): passiamo la lista di esercizi (Esercizi)
                /// ad EsercizioView che al suo interno li gestirà singolarmente
                
                // Bottone 1
                NavigationLink {
                    EsercizioView(
                        esercizi: model.lessonsList[lessonIndex].argomenti.items[0].esercizi,
                        onComplete: {
                            markCompleted(lessonIndex: lessonIndex, argIndex: 0)
                        }
                    )
                } label: {
                    Text(model.lessonsList[lessonIndex].argomenti.items[0].number)
                        .font(.system(size: 60))
                        .padding(51)
                        .foregroundColor(model.lessonsList[lessonIndex].argomenti.items[0].completed
                                                                 ? Color(.systemGray5)
                                                                 : Color(r: 182, g: 23, b: 45, opacity: 100))
                        .background(
                            model.lessonsList[lessonIndex].argomenti.items[0].completed
                            ? Color(r: 182, g: 23, b: 45, opacity: 100)
                            : Color(.systemGray5)
                )
            }
                /*.background(
                    model.lessonsList[lessonIndex].argomenti.items[0].completed
                    ? Color(r: 182, g: 23, b: 45, opacity: 100)
                    : Color(.systemGray5)
                )*/
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(
                            Color(r: 182, g: 23, b: 45, opacity: 100),
                            lineWidth: 4
                        )
                )
                .offset(x: -104, y: -28)

                
                // Bottone 2
                NavigationLink {
                    EsercizioView(
                        esercizi: buttonTwo.esercizi,
                        onComplete: {
                            markCompleted(lessonIndex: lessonIndex, argIndex: 0)
                        }
                    )
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
                    EsercizioView(
                        esercizi: buttonThree.esercizi,
                        onComplete: {
                            markCompleted(lessonIndex: lessonIndex, argIndex: 0)
                        }
                    )
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
    
    private func markCompleted(lessonIndex: Int, argIndex: Int) {
        model.lessonsList[lessonIndex].argomenti.items[argIndex].completed = true
    }

}

