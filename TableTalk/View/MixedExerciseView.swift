import SwiftUI
import UniformTypeIdentifiers

struct MixedExerciseView: View {
    let esercizi: [Esercizio<EsercizioContent, EsercizioContent>]
    let onComplete: () -> Void
    
    @State private var currentIndex = 0
    @State private var userInput = ""
    @Environment(\.dismiss) var dismiss
    
    // Opzioni di disturbo come nel secondo esercizio
    let fakeOptions = ["Bread", "Water", "Wine", "Cheese"]
    
    var body: some View {
        VStack(spacing: 20) {
            if currentIndex < esercizi.count {
                let attuale = esercizi[currentIndex]
                
                Text("Esercizio \(currentIndex + 1) di \(esercizi.count)")
                    .font(.caption).foregroundColor(.secondary)

                switch attuale.question {
                case .text(let domanda):
                    // --- LAYOUT SCRITTURA (BOTTONE 1) ---
                    VStack(spacing: 20) {
                        Text(domanda)
                            .font(.title2).bold()
                        
                        TextField("Risposta...", text: $userInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 40)
                        
                        Button("Verifica") {
                            validateText(attuale)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color(red: 182/255, green: 23/255, blue: 45/255))
                    }

                case .imageAsset(let path):
                    // --- LAYOUT IDENTICO A ESERCIZIO 2 (DROP) ---
                    VStack(spacing: 25) {
                        Text("Trascina la parola corretta sulla foto")
                            .font(.headline)
                        
                        // AREA DROP (Identica a MatchingExerciseView)
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 250, height: 250)
                                .shadow(radius: 5)
                            
                            Image(path) // <-- Il path deve essere il nome esatto negli Assets
                                .resizable()
                                .scaledToFit()
                                .frame(width: 230, height: 230)
                                .cornerRadius(15)
                        }
                        .onDrop(of: [UTType.text], isTargeted: nil) { providers in
                            handleDrop(providers: providers, targetEx: attuale)
                        }
                        
                        // SCELTE MULTIPLE (Come Esercizio 2)
                        let choices = prepareChoices(for: attuale)
                        HStack(spacing: 15) {
                            ForEach(choices, id: \.self) { choice in
                                Text(choice)
                                    .padding()
                                    .background(Color(red: 182/255, green: 23/255, blue: 45/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .onDrag { NSItemProvider(object: choice as NSString) }
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 247/255, blue: 238/255))
    }
    
    // Funzioni di supporto
    private func prepareChoices(for ex: Esercizio<EsercizioContent, EsercizioContent>) -> [String] {
        if case let .text(correct) = ex.answer {
            return ([correct] + fakeOptions.shuffled().prefix(2)).shuffled()
        }
        return []
    }
    
    private func validateText(_ ex: Esercizio<EsercizioContent, EsercizioContent>) {
        if case let .text(correct) = ex.answer,
           userInput.lowercased().trimmingCharacters(in: .whitespaces) == correct.lowercased() {
            next()
        }
    }
    
    private func handleDrop(providers: [NSItemProvider], targetEx: Esercizio<EsercizioContent, EsercizioContent>) -> Bool {
        guard let provider = providers.first else { return false }
        provider.loadObject(ofClass: NSString.self) { (string, _) in
            DispatchQueue.main.async {
                if let dropped = string as? String, case let .text(correct) = targetEx.answer,
                   dropped.lowercased() == correct.lowercased() {
                    next()
                }
            }
        }
        return true
    }
    
    private func next() {
        withAnimation {
            if currentIndex + 1 < esercizi.count {
                currentIndex += 1
                userInput = ""
            } else {
                onComplete()
                dismiss()
            }
        }
    }
}
