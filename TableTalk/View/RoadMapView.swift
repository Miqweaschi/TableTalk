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
                backgroundImage(for: currentLesson)
                
                NavigationStack {
                    // BOTTONE 1: Usa EsercizioView (passa la struct Esercizi intera)
                    NavigationLink {
                        MatchingExerciseView(
                            esercizi: currentLesson.argomenti.items[0].esercizi.items,
                            onComplete: { markCompleted(lessonIndex: lessonIndex, argIndex: 0) }
                        )
                        
                    } label: {
                        buttonLabel(argIndex: 0)
                    }
                    .background(model.lessonsList[lessonIndex].argomenti.items[0].completed ? Color(red: 182/255, green: 23/255, blue: 45/255) : Color(.systemGray5))
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color(red: 182/255, green: 23/255, blue: 45/255), lineWidth: 4)
                    )
                    .offset(x: -97, y: -33)
                    
                    // RoadMapView.swift - All'interno del NavigationStack

                    // BOTTONE 2: Passaggio diretto a SentenceDragExerciseView
                        NavigationLink {
                            SentenceDragExerciseView(
                                esercizi: currentLesson.argomenti.items[1].esercizi.items,
                                onCorrect: {
                                    markCompleted(lessonIndex: lessonIndex, argIndex: 1)
                                }
                            )
                    } label: {
                        buttonLabel(argIndex: 1)
                    }
                    .background(model.lessonsList[lessonIndex].argomenti.items[1].completed ? Color(red: 182/255, green: 23/255, blue: 45/255) : Color(.systemGray5))
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color(red: 182/255, green: 23/255, blue: 45/255), lineWidth: 4)
                    )
                    .offset(x: 105, y: 44)
                    
                    // BOTTONE 3: Usa MixedExerciseView (passa l'ARRAY .items)
                    NavigationLink {
                        MixedExerciseView(
                            esercizi: currentLesson.argomenti.items[2].esercizi.items,
                            onComplete: { markCompleted(lessonIndex: lessonIndex, argIndex: 2) }
                        )
                    } label: {
                        buttonLabel(argIndex: 2)
                    }
                    .background(model.lessonsList[lessonIndex].argomenti.items[2].completed ? Color(red: 182/255, green: 23/255, blue: 45/255) : Color(.systemGray5))
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color(red: 182/255, green: 23/255, blue: 45/255), lineWidth: 4)
                    )
                    .offset(x: -101, y: 88)
                }
                .background(Color.clear)
            }
        }
    }
    
    // Funzione per lo sfondo
    @ViewBuilder
        private func backgroundImage(for lesson: Lesson) -> some View {
            let arg1 = lesson.argomenti.items[0].completed
            let arg2 = lesson.argomenti.items[1].completed
            let arg3 = lesson.argomenti.items[2].completed
            
            // Logica per Lezione 1
            if lesson.number == "1" {
                if arg1 && arg2 && arg3 {
                    Image("RoadMap1_all_ok").resizable().ignoresSafeArea()
                } else if arg1 && arg2 {
                    Image("RoadMap1_2_ok").resizable().ignoresSafeArea()
                } else if arg1 {
                    Image("RoadMap1_1_ok").resizable().ignoresSafeArea()
                } else {
                    Image("RoadMap1").resizable().ignoresSafeArea()
                }
            }
            // Logica per Lezione 2
            else if lesson.number == "2" {
                if arg1 && arg2 && arg3 {
                    Image("RoadMap2_all_ok").resizable().ignoresSafeArea()
                } else if arg1 {
                    Image("RoadMap1_1_ok").resizable().ignoresSafeArea()
                } else {
                    Image("RoadMap2").resizable().ignoresSafeArea()
                }
            }

        }
    
    // Funzione helper per le etichette dei bottoni
    @ViewBuilder
    private func buttonLabel(argIndex: Int) -> some View {
        let arg = model.lessonsList[lessonIndex].argomenti.items[argIndex]
        Text(arg.number)
            .font(.system(size: 60))
            .padding(48)
            .foregroundColor(arg.completed ? Color(.systemGray5) : Color(red: 182/255, green: 23/255, blue: 45/255))
    }
    
    private func markCompleted(lessonIndex: Int, argIndex: Int) {
        model.objectWillChange.send()
        model.lessonsList[lessonIndex].argomenti.items[argIndex].completed = true
    }
}
