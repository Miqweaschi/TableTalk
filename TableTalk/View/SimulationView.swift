import SwiftUI

struct SimulationView: View {
    @EnvironmentObject var model: Model
    @State private var currentStepIndex = 0
    @State private var isError = false
    @State private var isCompleted = false

    // Opzioni multiple per ogni step (4 per step)
    let optionsPerStep: [[String]] = [
        ["Hello, yes. Welcome!", "No, thanks", "Good afternoon", "Maybe"],
        ["For how many?", "Good evening", "Two plates", "Thank you"],
        ["Follow me, please", "Good morning", "One plate", "You are welcome"]
    ]
    
    var body: some View {
        ZStack {
            if isCompleted {
                // Sfondo diverso quando completata
                Image("Simulation")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                // Sfondo normale della simulazione
                Image("Person3")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Spacer()
                    
                    // Progress Bar
                    ProgressView(value: Double(currentStepIndex), total: Double(model.simulationDialogue.count))
                        .padding(.horizontal)
                        .tint(Color(red: 182/255, green: 23/255, blue: 45/255))
                    
                    // AREA CLIENTE (Fumetto + Immagine)
                    let currentDialogue = model.simulationDialogue[currentStepIndex]
                    
                    VStack {
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
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    // AREA BOTTONI MULTIPLA
                    ZStack {
                        // Rettangolo dietro ai bottoni
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(1.0))
                            .shadow(radius: 5)
                        
                        let columns = [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ]
                        
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(optionsPerStep[currentStepIndex], id: \.self) { option in
                                Button(action: {
                                    validateAnswer(option)
                                }) {
                                    Text(option)
                                        .font(.system(size: 12))
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color(red: 182/255, green: 23/255, blue: 45/255))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    
                    Spacer()
                }
                .padding(.vertical, 20)
            }
        }
    }
    
    // Validazione della risposta
    private func validateAnswer(_ userAnswer: String) {
        let correctAnswer = model.simulationDialogue[currentStepIndex].expectedAnswer.lowercased()
        
        if userAnswer.lowercased() == correctAnswer {
            isError = false
            if currentStepIndex < model.simulationDialogue.count - 1 {
                withAnimation {
                    currentStepIndex += 1
                }
            } else {
                // Segnala fine simulazione
                withAnimation {
                    isCompleted = true
                }
                model.totalProgress += 0.1
            }
        } else {
            isError = true
        }
    }
    
    // Triangolo per il fumetto
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
