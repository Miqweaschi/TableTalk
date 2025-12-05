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
   @State  var isAuthonticate : Bool = false
    
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
                
                    Spacer()
            }
            .background(Color(r: 255,g: 247,b: 238,opacity: 100))
            
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomeView()
    }
}

