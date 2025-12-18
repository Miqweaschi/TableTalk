import SwiftUI

struct SimulationView: View {
    @EnvironmentObject var model: Model
    let scenario: SimulationScenario
    
    @State private var currentStepIndex = 0
    @State private var isError = false
    @State private var shakeOffset: CGFloat = 0
    @State private var isCompleted = false
    @Environment(\.dismiss) var dismiss
    
    let brandRed = Color(red: 182/255, green: 23/255, blue: 45/255)

    var body: some View {
        ZStack {
            // SFONDO
            Image(isCompleted ? "Simulation" : scenario.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
                .ignoresSafeArea()
                .offset(y:-100)
            
            VStack(spacing: 0) {
                // HEADER PROGRES BAR
                if !isCompleted {
                    ProgressView(value: Double(currentStepIndex), total: Double(scenario.steps.count))
                        .tint(brandRed)
                        .padding(.horizontal, 40)
                        .padding(.top, 60)
                }
                
                // CORPO
                if isCompleted {
                    Spacer()
                    VStack(spacing: 20) {
                        /*Text("Excellent Job!").font(.largeTitle).bold().foregroundColor(.white).shadow(radius: 5)*/
                        Button("Torna al Menu") { dismiss() }
                            .font(.headline).foregroundColor(brandRed).padding()
                            .background(.white).cornerRadius(15).shadow(radius: 5)
                            
                    }
                    .padding(.bottom, 200)
                } else {
                    // FUMETTO PERSONAGGIO
                    if currentStepIndex < scenario.steps.count {
                        let step = scenario.steps[currentStepIndex]
                        
                        Text(step.customerLine)
                            .font(.title3)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(
                                SpeechBubbleShape()
                                    .fill(Color.white)
                                    .shadow(radius: 5)
                            )
                            .frame(maxWidth: 280)
                            .offset(x: -40, y: 50)
                    }
                    
                    Spacer()
                    
                    // RISPOSTE
                    if currentStepIndex < scenario.steps.count {
                        let step = scenario.steps[currentStepIndex]
                        
                        VStack(spacing: 15) {
                            Text("Scegli la risposta:").font(.caption).bold().foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading).padding(.top, 25).padding(.horizontal)
                            
                            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 12) {
                                ForEach(step.options, id: \.self) { opt in
                                    Button(opt) { validateAnswer(opt) }
                                        .font(.system(size: 15, weight: .semibold))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 60)
                                        .background(brandRed)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal)
                            // MODIFICA QUI: Aumentato da 50 a 100 per alzare i pulsanti
                            .padding(.bottom, 110)
                        }
                        .background(.white)
                        .simCornerRadius(30, corners: [.topLeft, .topRight])
                        .shadow(radius: 10)
                        .offset(x: shakeOffset)
                        .ignoresSafeArea(edges: .bottom)
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .animation(.easeInOut, value: currentStepIndex)
    }
    
    private func validateAnswer(_ user: String) {
        guard currentStepIndex < scenario.steps.count else { return }
        
        let correct = scenario.steps[currentStepIndex].expectedAnswer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if user.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == correct {
            if currentStepIndex < scenario.steps.count - 1 { currentStepIndex += 1 }
            else { isCompleted = true; model.totalProgress += 0.1 }
        } else {
            withAnimation(.default) { shakeOffset = 10 }
            withAnimation(.default.delay(0.1)) { shakeOffset = 0 }
        }
    }
}

// FORMA FUMETTO
struct SpeechBubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 15)
        
        let tailPath = UIBezierPath()
        tailPath.move(to: CGPoint(x: width - 40, y: height))
        tailPath.addLine(to: CGPoint(x: width - 20, y: height + 15))
        tailPath.addLine(to: CGPoint(x: width - 20, y: height))
        
        path.append(tailPath)
        
        return Path(path.cgPath)
    }
}

// ESTENSIONI DI SUPPORTO
extension View {
    func simCornerRadius(_ r: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(SimRoundedCorner(radius: r, corners: corners))
    }
}

struct SimRoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
