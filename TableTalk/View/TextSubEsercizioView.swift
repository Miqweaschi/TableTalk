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
    
    var body: some View {
        VStack(spacing: 20) {

            contentView(esercizio.question)

            TextField("Rispondi qui", text: $userAnswer)
                .textFieldStyle(.roundedBorder)

            Button("Conferma") {
                Task {
                    await checkAnswer()
                }
            }

            if showError {
                Text("Risposta errata")
                    .foregroundColor(.red)
            }
        }
    }
    
    private func checkAnswer() async {
        // prende la vera risposta corretta
        guard case let .text(correct) = esercizio.answer else { return }

        // Parsing della risposta data dall'utente
        if userAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased() == correct.lowercased() {
            showError = false
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            userAnswer = ""
            onCorrectAnswer()
        } else {
            showError = true
        }
    }
    
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
