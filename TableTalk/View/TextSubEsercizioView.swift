//
//  SubEsercizioView.swift
//  TableTalk
//
//  Created by AFP PAR 32 on 15/12/25.
//

import SwiftUI

struct TextSubEsercizioView: View {
    let esercizio: Esercizio<EsercizioContent, EsercizioContent>
    let onCorrectAnswer: () -> Void
    
    @State private var userAnswer: String = ""
    @State private var showError = false
    @State private var answerState: AnswerState = .none
    
    enum AnswerState {
        case none
        case correct
        case wrong
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                
                // Mostra la domanda o immagine
                contentView(esercizio.question)
                
                // Campo di testo
                TextField("Rispondi qui", text: $userAnswer)
                    .textFieldStyle(.roundedBorder)
                    .disabled(answerState == .correct) // blocca input mentre verde
                
                // Bottone conferma
                Button("Conferma") {
                    Task {
                        await checkAnswer()
                    }
                }
                .disabled(userAnswer.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .padding()
                
                // Messaggio di errore
                if showError {
                    Text("Risposta errata")
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
    }
    
    // Funzione che controlla la risposta
    private func checkAnswer() async {
        guard case let .text(correct) = esercizio.answer else { return }
        
        let cleanedUser = userAnswer
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        if cleanedUser == correct.lowercased() {
            answerState = .correct
            showError = false
            
            // Aspetta un secondo prima di passare al prossimo esercizio
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            
            userAnswer = ""
            answerState = .none
            onCorrectAnswer()
        } else {
            answerState = .wrong
            userAnswer = ""
            showError = true
        }
    }
    
    // Colore di sfondo dinamico
    private var backgroundColor: Color {
        switch answerState {
        case .correct:
            return Color.green.opacity(0.25)
        case .wrong:
            return Color.red.opacity(0.25)
        case .none:
            return Color.white // sfondo neutro
        }
    }
    
    // ViewBuilder per mostrare la domanda corretta
    @ViewBuilder
    private func contentView(_ content: EsercizioContent) -> some View {
        switch content {
        case .text(let string):
            Text(string)
                .font(.title2)
        case .imageAsset(let path):
            Image(path)
                .resizable()
                .scaledToFit()
        }
    }
}
