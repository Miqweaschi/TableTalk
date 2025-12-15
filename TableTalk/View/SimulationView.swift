//
//  SimulationView.swift
//  TableTalk
//
//  Created by AFP PAR 14 on 15/12/25.
//

import Foundation
import Combine
import SwiftUI


struct SimulationView:  View {
    
    @EnvironmentObject var model : Model
    
    var body : some View {
        VStack{
            
            
            Text("Simulation")
                .font(Font.largeTitle)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.bottom,20)
                .padding(.top,50)
                .background(Color(r:182,g:23,b:45,opacity:100))
            
            Spacer()
        }
        .background(Color(r: 255,g: 247,b: 238,opacity: 100))
    }
}

#Preview {
    SimulationView()
}
