import SwiftUI

struct SimulationView: View {
    @EnvironmentObject var model: Model
    @State private var currentStepIndex = 0
    @State private var userInput = ""
    @State private var isError = false
    @State private var isCompleted = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Simulation")
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.top, 50)
                .padding(.bottom, 20)
                .background(Color(red: 182/255, green: 23/255, blue: 45/255))

            ZStack {
                Color(red: 255/255, green: 247/255, blue: 238/255).ignoresSafeArea()
                
                if !isCompleted {
                    VStack(spacing: 30) {
                        // Progress Bar semplice
                        ProgressView(value: Double(currentStepIndex), total: Double(model.simulationDialogue.count))
                            .padding(.horizontal)
                            .tint(Color(red: 182/255, green: 23/255, blue: 45/255))

                        // AREA CLIENTE (Personaggio + Fumetto)
                        VStack {
                            let currentDialogue = model.simulationDialogue[currentStepIndex]
                            
                            // Fumetto
                            Text(currentDialogue.customerLine)
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(radius: 2)
                                .overlay(
                                    Triangle()
                                        .fill(Color.white)
                                        .frame(width: 20, height: 10)
                                        .offset(y: 10),
                                    alignment: .bottom
                                )
                                .padding(.horizontal)

                            // Immagine Personaggio
                            Image(systemName: "person.circle.fill") // Qui metterai il tuo asset
                                .resizable()
                                .frame(width: 140, height: 140)
                                .foregroundColor(Color(red: 182/255, green: 23/255, blue: 45/255))
                                .padding(.top, 25)
                        }

                        Spacer()

                        // AREA RISPOSTA
                        VStack(spacing: 15) {
                            TextField("Scrivi la tua risposta...", text: $userInput)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).stroke(isError ? Color.red : Color.gray))
                                .padding(.horizontal)
                                .autocorrectionDisabled()

                            Button(action: validateAnswer) {
                                Text("Invia")
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(red: 182/255, green: 23/255, blue: 45/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.bottom, 40)
                    }
                } else {
                    // Schermata di fine
                    VStack(spacing: 20) {
                        Text("Ottimo lavoro!")
                            .font(.title)
                            .bold()
                        Text("Hai completato la simulazione.")
                        Button("Riprova") {
                            currentStepIndex = 0
                            isCompleted = false
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
        }
    }

    private func validateAnswer() {
        let correctAnswer = model.simulationDialogue[currentStepIndex].expectedAnswer.lowercased()
        
        if userInput.lowercased().contains(correctAnswer) {
            isError = false
            if currentStepIndex < model.simulationDialogue.count - 1 {
                withAnimation {
                    currentStepIndex += 1
                    userInput = ""
                }
            } else {
                isCompleted = true
                model.totalProgress += 0.1 // Aggiorna il progresso globale
            }
        } else {
            isError = true
        }
    }
}

// Forma per il triangolo del fumetto
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
