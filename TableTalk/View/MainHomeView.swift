// File usato per gestire il reparto grafico della pagina iniziale dell'applicazione

import Foundation
import SwiftUI

struct MainHomeView: View {
    @State  var nome : Utente = Utente(name: "")
    @State  var isAuthonticated : Bool = false
    
    // Contiene la data corrente
    @State private var selectedDate = Date()
    
    // Valore numerico del progresso
    @State private var progress: Double = 0.0
    
    var body: some View {
        VStack {
            Text("Welcome Back!")
                .font(Font.largeTitle)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.bottom,20)
                .padding(.top,50)
                .background(Color(r:182,g:23,b:45,opacity:100))
            
            Spacer()
            
            ZStack{
                Circle()
                    .stroke(
                        Color.gray.opacity(0.5),
                        lineWidth: 20
                    )
                    .frame(width: 110, height: 110)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.init(r: 182, g: 23, b: 45, opacity: 100),
                        style: StrokeStyle(
                            lineWidth: 20,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
                    .frame(width: 110, height: 110)
                Text("\(progress * 10, specifier: "%.0f")/10")
                    .bold()
            }
            
            Spacer()
            
            //DatePicker è una funzione che ci permette di implementare il calendario
            DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .padding(.top,10)
                .tint(Color(r:182,g:23,b:45,opacity:100))
                .offset(x: 0, y: -20)
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
