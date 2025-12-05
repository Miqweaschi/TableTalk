//
//  MainHomeView.swift
//  TableTalk
//
//  Created by AFP PAR 21 on 05/12/25.
//

import Foundation
import SwiftUI

struct MainHomeView: View {
   
  
   @State  var nome : Utente = Utente(name: "")
   @State  var isAuthonticated : Bool = false
   @State private var selectedDate = Date()
    @State private var progress: Double = 0.2 //progress va da 0.0 a 1
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
            VStack {
                Text("Welcome Back!")
                    .font(Font.largeTitle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom,20)
                    .padding(.top,50)
                    .background(Color(r:182,g:23,b:45,opacity:100))
                    .shadow(color:.black,    radius : 0)
                
                VStack{
                    Gauge(value: progress , label: { Text("\(Int(progress * 10))/10") })
                        .frame(width: 200, height: 100)
                        .padding(.top,100)
                        .tint(Color(r:182,g:23,b:45,opacity:100))
                }
                // Date Picker
               
                DatePicker("Attività", selection: $selectedDate, displayedComponents: [.date])
                
                .datePickerStyle(.graphical)
                .padding(.top,10)
                .tint(Color(r:182,g:23,b:45,opacity:100))
            
                    
                Spacer()
                
            }
    
            
        
            .background(Color(r: 255,g: 247,b: 238,opacity: 100))
            }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

