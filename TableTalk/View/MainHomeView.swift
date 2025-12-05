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
                
        
            
                
                // Date Picker
                VStack{
                    DatePicker("Attività", selection: $selectedDate, in:
                                Date()...,
                               displayedComponents: .date)
                                                     
                }
                .datePickerStyle(.graphical)
                
                
                
                
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

