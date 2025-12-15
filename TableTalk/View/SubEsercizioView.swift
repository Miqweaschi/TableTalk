//
//  SubEsercizioView.swift
//  TableTalk
//
//  Created by AFP PAR 32 on 15/12/25.
//

import SwiftUI

struct SubEsercizioView: View {
    let esercizio: Esercizio<EsercizioContent, EsercizioContent>

    var body: some View {
        VStack(spacing: 16) {
            Text("Domanda")
                .font(.headline)
            contentView(esercizio.question)

            Text("Risposta")
                .font(.headline)
            contentView(esercizio.answer)
        }
        .padding()
    }

    @ViewBuilder
    private func contentView(_ content: EsercizioContent) -> some View {
        switch content {
        case .text(let string):
            Text(string)

        case .imageAsset(let path):
            Image(path)
                .resizable()
                .scaledToFit()
        }
    }
}

