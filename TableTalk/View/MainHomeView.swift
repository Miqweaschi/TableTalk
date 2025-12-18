import SwiftUI

struct MainHomeView: View {
    // 1. Colleghiamo il Model
    @EnvironmentObject var model: Model
    
    @State var nome : Utente = Utente(name: "")
    @State var isAuthonticated : Bool = false
    
    // Contiene la data corrente
    @State private var selectedDate = Date()
    
    // Valore numerico del progresso
    @State private var progress: Double = 0.0
    
    // Definisco il colore qui per comodità (così se lo cambi, cambia ovunque)
    let mainColor = Color(red: 182/255, green: 23/255, blue: 45/255)
    
    var body: some View {
        VStack {
            // HEADER
            Text("Welcome Back!")
                .font(Font.largeTitle)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
                .padding(.top, 50)
                .background(mainColor)
            
            Spacer()
            
            Text("YOUR PROGRESS")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            
            // --- PROGRESS BAR ACCATTIVANTE ---
            ZStack {
                // 1. Sfondo del cerchio (Versione chiara del tuo rosso)
                Circle()
                    .stroke(mainColor.opacity(0.2), lineWidth: 20)
                    .frame(width: 150, height: 150)
                
                // 2. Barra di progresso con Gradiente e Ombra
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        // Gradiente lineare per dare un effetto 3D
                        LinearGradient(
                            colors: [mainColor, mainColor.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    // L'ombra crea l'effetto "Glow" (luminoso)
                    .shadow(color: mainColor.opacity(0.5), radius: 10, x: 0, y: 0)
                    .frame(width: 150, height: 150)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: progress)
                
                // 3. Testo centrale migliorato
                VStack(spacing: 0) {
                    Text("\(progress * 10, specifier: "%.0f")")
                        .font(.system(size: 48, weight: .heavy, design: .rounded))
                        .foregroundColor(mainColor)
                    
                    Text("/ 10")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 20)
            // ---------------------------------
            
            Spacer()
            
            // DatePicker
            DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .tint(mainColor)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(mainColor, lineWidth: 2)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 255/255, green: 247/255, blue: 238/255))
                        )
                        // Aggiungo un'ombra leggera anche al calendario per coerenza
                        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                )
                .padding(.horizontal, 20)
                .padding(.top, 10)
            
            Spacer()
        }
        .background(Color(red: 255/255, green: 247/255, blue: 238/255))
        .onAppear {
            updateProgress()
        }
    }
    
    // Funzione helper
    func updateProgress() {
        let calculated = model.calculateGlobalProgress()
        // Animazione Spring per un movimento più elastico
        withAnimation {
            self.progress = calculated
        }
    }
}

struct MainHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomeView()
            .environmentObject(Model())
    }
}
