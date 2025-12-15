//
//  EsercizioView.swift
//  TableTalk
//
//  Created by AFP PAR 32 on 15/12/25.
//

import SwiftUI

struct EsercizioView: View {
    let esercizi: Esercizi<EsercizioContent, EsercizioContent>
    @State private var currentIndex: Int = 0
    @Environment(\.presentationMode) var presentationMode
    let onComplete: () -> Void
    
    var body: some View {
        VStack {
            if currentIndex < esercizi.items.count {
                let esercizio = esercizi.items[currentIndex]
                
                // In base al tipo della 'question' (String o Image) chiamo la View dedicata
                switch esercizio.question {
                case .text:
                    // Se la lista di esercizi è di tipo <String, String> allora chiamo:
                    TextSubEsercizioView(
                        // Qui passiamo l'esercizio i-esimo a SubEsercizioView
                        esercizio: esercizi.items[currentIndex],
                        onCorrectAnswer: goToNext
                    )
                case .imageAsset:
                    // Altrimenti chiamiamo la View dedicata ad esercizi del tipo <Image, String>
                    Text("Non implementato")
                }
            } else {
                Text("Esercizi completati!")
                    .font(.title)
                    .onAppear {
                        onComplete()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
            }
        }
        .padding()
    }
    
    private func goToNext() {
        currentIndex += 1
    }
}
