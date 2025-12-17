import SwiftUI

struct SimulationView: View {
    @EnvironmentObject var model: Model
    
    // DATI IN INGRESSO
    let scenario: SimulationScenario
    
    @State private var currentStepIndex = 0
    @State private var isError = false
    @State private var shakeOffset: CGFloat = 0
    @State private var isCompleted = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // 1. SFONDO
            // DEVE ESSERE COSÌ:
            Image(isCompleted ? "Simulation" : scenario.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill) // Simile a scaledToFill
                .frame(width: UIScreen.main.bounds.width) // Forza la larghezza dello schermo
                .clipped() // Taglia l'eccesso
                .ignoresSafeArea()
            
            // 2. CONTENUTO PRINCIPALE
            VStack(spacing: 0) { // Spacing 0 per controllo preciso
                
                // --- HEADER ---
                if !isCompleted {
                    VStack(spacing: 12) {
                        Text(scenario.title)
                            .font(.headline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                        
                        ProgressView(value: Double(currentStepIndex), total: Double(scenario.steps.count))
                            .tint(Color(red: 182/255, green: 23/255, blue: 45/255))
                            .padding(.horizontal, 40)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 20) // Un po' di aria sotto l'header
                }
                
                // --- CORPO ---
                if isCompleted {
                    // *** SCHERMATA FINE ***
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Text("Excellent Job!")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                        
                        Button(action: { dismiss() }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("Torna al Menu")
                            }
                            .font(.headline)
                            .foregroundColor(Color(red: 182/255, green: 23/255, blue: 45/255))
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(.bottom, 120) // Spazio extra per la TabBar
                    
                } else {
                    // *** SIMULAZIONE IN CORSO ***
                    
                    // 1. FUMETTO CLIENTE (Ora è più in alto)
                    if currentStepIndex < scenario.steps.count {
                        let currentStep = scenario.steps[currentStepIndex]
                        
                        VStack {
                            Text(currentStep.customerLine)
                                .font(.title3) // Testo leggermente più grande
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 4)
                                .overlay(
                                    Triangle()
                                        .fill(Color.white)
                                        .frame(width: 20, height: 12)
                                        .offset(y: 10), // La punta del fumetto
                                    alignment: .bottom
                                )
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 40) // Spinge il fumetto un po' giù dall'header, ma non troppo
                    }
                    
                    // Questo Spacer spinge le risposte verso il basso,
                    // ma permette al fumetto di stare in alto
                    Spacer()
                    
                    // 2. PANNELLO RISPOSTE
                    if currentStepIndex < scenario.steps.count {
                        let currentStep = scenario.steps[currentStepIndex]
                        
                        VStack(spacing: 15) {
                            Text("Scegli la risposta:")
                                .font(.caption).bold()
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .padding(.top, 15)
                            
                            let columns = [GridItem(.flexible()), GridItem(.flexible())]
                            
                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach(currentStep.options, id: \.self) { option in
                                    Button(action: { validateAnswer(option) }) {
                                        Text(option)
                                            .font(.system(size: 14, weight: .semibold)) // Font leggibile
                                            .multilineTextAlignment(.center)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 55) // Altezza fissa comoda per il dito
                                            .padding(.horizontal, 4)
                                            .background(Color(red: 182/255, green: 23/255, blue: 45/255))
                                            .foregroundColor(.white)
                                            .cornerRadius(12)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 20) // Spazio interno al pannello bianco
                        }
                        .background(Color.white.opacity(0.95))
                        .cornerRadius(25, corners: [.topLeft, .topRight])
                        .shadow(radius: 10)
                        .offset(x: shakeOffset) // Animazione errore
                        .overlay(
                            // Bordo rosso se errore
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.red, lineWidth: isError ? 3 : 0)
                                .mask(Rectangle().padding(.bottom, -50)) // Nasconde bordo sotto
                        )
                        // !!! QUESTA È LA FIX FONDAMENTALE !!!
                        // Aggiunge spazio sotto affinché la TabBar non copra i bottoni
                        .padding(.bottom, 85)
                    }
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom) // Evita problemi se mai ci fosse tastiera
        }
        .animation(.easeInOut, value: currentStepIndex)
        .animation(.easeInOut, value: isCompleted)
    }
    
    // --- LOGICA (Uguale a prima) ---
    private func validateAnswer(_ userAnswer: String) {
        guard currentStepIndex < scenario.steps.count else { return }
        
        let currentStep = scenario.steps[currentStepIndex]
        // Pulizia stringhe per confronto sicuro
        let correct = currentStep.expectedAnswer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let user = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if user == correct {
            isError = false
            if currentStepIndex < scenario.steps.count - 1 {
                currentStepIndex += 1
            } else {
                isCompleted = true
                model.totalProgress += 0.1
            }
        } else {
            isError = true
            shake()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { isError = false }
        }
    }
    
    private func shake() {
        let amount: CGFloat = 10
        withAnimation(.default) { shakeOffset = amount }
        withAnimation(.default.delay(0.1)) { shakeOffset = -amount }
        withAnimation(.default.delay(0.2)) { shakeOffset = amount/2 }
        withAnimation(.default.delay(0.3)) { shakeOffset = 0 }
    }
    
    struct Triangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.closeSubpath()
            return path
        }
    }
}

// Estensione necessaria per gli angoli arrotondati selettivi
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
