// File usato per gestire il reparto grafico della pagina iniziale dell'applicazione



import Foundation
import SwiftUI

struct MainHomeView: View {
   
  
   @State  var nome : Utente = Utente(name: "")
   @State  var isAuthonticated : Bool = false
    
    
    //selectedDate è una variabile che contiene la data corrente. ci servirà nella funzione DatePicker come variabile in input utile a cerchiare sul calendario il giorno corrente.
   @State private var selectedDate = Date()
    
    
    //progress è utile come variabile perchè contiene il valore della progression bar(Gauge), progress va da 0.0 a 1 dove 0.0 è lo 0% mentre 1.0 è il 100%.
    @State private var progress: Double = 0.2
    
    
    var body: some View {
        
        //Questa VStack rappresenta il blocco rosso in alto con la scritta "Welcome Back!"
            VStack {
                Text("Welcome Back!")
                    .font(Font.largeTitle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom,20)
                    .padding(.top,50)
                    .background(Color(r:182,g:23,b:45,opacity:100))
                
                
        //Questa VStack contiene la progression bar, viene utilizzata la funzione Gauge che prende in input una variabile con il valore e la progressione che deve mostrare la progression bar.
                VStack{
                    Gauge(value: progress , label: { Text("\(Int(progress * 10))/10") })
                        .frame(width: 200, height: 100)
                        .padding(.top,100)
                        .tint(Color(r:182,g:23,b:45,opacity:100))
                }
                
                
          //DatePicker è una funzione che ci permette di implementare il calendario
                
                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                
                
                //.datePickerStyle impostandolo a graphical ci permette di mostrarlo in primo piano, ci sono un altro paio di opzioni come per esempio la visualizzazione a "ruota" ma a noi interessa questa.
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

