//
//  ArgomentoView.swift
//  TableTalk
//
//  Created by AFP PAR 32 on 10/12/25.
//

import SwiftUI

struct ArgomentoView: View {
    let argomento: Argomento
    
    var body: some View {
        // Qui gestiremo il singolo argomento passato in RoadMapView()
        Text(argomento.content)
    }
}
