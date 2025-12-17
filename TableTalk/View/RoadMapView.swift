import Foundation
import SwiftUI
import UIKit
import Combine

struct RoadMapView: View {
    let lesson: Lesson
    let lessonIndex: Int
    @ObservedObject var model: Model
    
    var body: some View {
        // Protezione contro indici fuori limite
        if lessonIndex < model.lessonsList.count {
            let currentLesson = model.lessonsList[lessonIndex]
            
            ZStack {
                // Sfondo dinamico
                backgroundImage(for: currentLesson.number)
                
                NavigationStack {
                    // BOTTONE 1: Usa EsercizioView (passa la struct Esercizi intera)
                    NavigationLink {
                        EsercizioView(
                            esercizi: currentLesson.argomenti.items[0].esercizi,
                            onComplete: { markCompleted(lessonIndex: lessonIndex, argIndex: 0) }
                        )
                    } label: {
                        buttonLabel(argIndex: 0)
                    }
                    .offset(x: -104, y: -28)
                    
                    // BOTTONE 2: Usa MatchingExerciseView (passa l'ARRAY .items)
                    NavigationLink {
                        MatchingExerciseView(
                            esercizi: currentLesson.argomenti.items[1].esercizi.items,
                            onComplete: { markCompleted(lessonIndex: lessonIndex, argIndex: 1) }
                        )
                    } label: {
                        buttonLabel(argIndex: 1)
                    }
                    .offset(x: 110, y: 55)
                    
                    // BOTTONE 3: Usa MixedExerciseView (passa l'ARRAY .items)
                    NavigationLink {
                        MixedExerciseView(
                            esercizi: currentLesson.argomenti.items[2].esercizi.items,
                            onComplete: { markCompleted(lessonIndex: lessonIndex, argIndex: 2) }
                        )
                    } label: {
                        buttonLabel(argIndex: 2)
                    }
                    .offset(x: -110, y: 100)
                }
                .background(Color.clear)
            }
        }
    }
    
    // Funzione per lo sfondo
    @ViewBuilder
    private func backgroundImage(for number: String) -> some View {
        switch number {
        case "1": Image("RoadMap1").resizable().edgesIgnoringSafeArea(.vertical)
        case "2": Image("RoadMap1ok").resizable().edgesIgnoringSafeArea(.vertical)
        default: Image("RoadMap2ok").resizable().edgesIgnoringSafeArea(.vertical)
        }
    }
    
    // Funzione helper per le etichette dei bottoni
    @ViewBuilder
    private func buttonLabel(argIndex: Int) -> some View {
        let arg = model.lessonsList[lessonIndex].argomenti.items[argIndex]
        Text(arg.number)
            .font(.system(size: 60))
            .padding(51)
            .foregroundColor(arg.completed ? Color(.systemGray5) : Color(red: 182/255, green: 23/255, blue: 45/255))
            .background(arg.completed ? Color(red: 182/255, green: 23/255, blue: 45/255) : Color(.systemGray5))
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color(red: 182/255, green: 23/255, blue: 45/255), lineWidth: 4)
            )
    }
    
    private func markCompleted(lessonIndex: Int, argIndex: Int) {
        model.objectWillChange.send()
        model.lessonsList[lessonIndex].argomenti.items[argIndex].completed = true
    }
}
