//
//  EsercizioView.swift
//  TableTalk
//
//  Created by AFP PAR 32 on 15/12/25.
//

import SwiftUI

struct EsercizioView: View {
    let esercizi: Esercizi<EsercizioContent, EsercizioContent>
    
    var body: some View {
        ForEach(esercizi.items, id: \.id) { es in
            NavigationLink {
                SubEsercizioView(esercizio: es)
            } label: {
                Text("Esercizio")
            }
        }
    }
}

