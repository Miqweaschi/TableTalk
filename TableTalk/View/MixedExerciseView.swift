import SwiftUI
import UniformTypeIdentifiers

struct MixedExerciseView: View {
    let esercizi: [Esercizio<EsercizioContent, EsercizioContent>]
    let onComplete: () -> Void
    
    @State private var currentIndex = 0
    @State private var userInput = ""
    @State private var currentOptions: [String] = [] // Opzioni dinamiche (giuste + sbagliate)
    @Environment(\.dismiss) var dismiss
    
    // Distrattori generici per popolare le scelte quando mancano nel modello
    let extraVocabulary = ["Wine", "Water", "Menu", "Table", "Fork", "Knife", "Plate"]
    
    var body: some View {
        VStack(spacing: 30) {
            // Progresso
            progressHeader
            
            if currentIndex < esercizi.count {
                let attuale = esercizi[currentIndex]
                
                VStack(spacing: 40) {
                    if case .text(let frase) = attuale.question {
                        // --- LOGICA PRIMO ESERCIZIO: FILL IN THE BLANK ---
                        VStack(spacing: 20) {
                            Text("Completa la frase")
                                .font(.headline).foregroundColor(.secondary)
                            
                            Text(frase)
                                .font(.title2).bold().multilineTextAlignment(.center)
                                .padding()

                            // Area di input (come nel tuo primo esercizio)
                            TextField("Scrivi la risposta...", text: $userInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 40)
                                .autocorrectionDisabled()
                            
                            // Mostriamo le opzioni suggerite (Mix tra corrette e distrattori del modello)
                            Text("Suggerimenti:")
                                .font(.caption).foregroundColor(.gray)
                            
                            HStack {
                                ForEach(currentOptions, id: \.self) { opt in
                                    Button(opt) { userInput = opt } // Cliccando riempie il campo
                                        .font(.subheadline)
                                        .padding(8)
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .shadow(radius: 1)
                                }
                            }

                            Button("Verifica") {
                                validateText(attuale.answerText)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Color(red: 182/255, green: 23/255, blue: 45/255))
                        }
                        
                    } else if case .imageAsset(let path) = attuale.question {
                        // --- LOGICA SECONDO ESERCIZIO: DRAG & DROP SU IMMAGINE ---
                        VStack(spacing: 25) {
                            Text("Trascina la parola sull'immagine")
                                .font(.headline).foregroundColor(.secondary)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 20).fill(Color.white)
                                    .frame(width: 250, height: 250).shadow(radius: 5)
                                Image(path).resizable().scaledToFit().frame(width: 230, height: 230).cornerRadius(15)
                            }
                            .onDrop(of: [UTType.text], isTargeted: nil) { providers in
                                handleDrop(providers, attuale.answerText)
                            }
                            
                            // Griglia di opzioni (Corretta + extra)
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                                ForEach(currentOptions, id: \.self) { opzione in
                                    Text(opzione)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color(red: 182/255, green: 23/255, blue: 45/255))
                                        .foregroundColor(.white).cornerRadius(10)
                                        .onDrag { NSItemProvider(object: opzione as NSString) }
                                }
                            }
                            .padding(.horizontal, 40)
                        }
                    }
                }
                .onAppear { prepareRound() }
                .id(currentIndex)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 247/255, blue: 238/255))
    }
    
    // MARK: - Logica
    
    private func prepareRound() {
        let answer = esercizi[currentIndex].answerText
        
        if answer.contains("|") {
            // Per il TESTO: separa "Giuste | Sbagliate" e mischia tutto
            let parti = answer.components(separatedBy: "|")
            let tutte = parti.flatMap { $0.components(separatedBy: ",") }
                .map { $0.trimmingCharacters(in: .whitespaces) }
            currentOptions = Array(tutte.shuffled().prefix(4))
        } else {
            // Per l'IMMAGINE: prende la giusta + 3 a caso dal vocabolario extra
            let giusta = answer.trimmingCharacters(in: .whitespaces)
            let extra = extraVocabulary.filter { $0 != giusta }.shuffled().prefix(3)
            currentOptions = ([giusta] + Array(extra)).shuffled()
        }
    }
    
    private func validateText(_ correctString: String) {
        // Estrae solo la parte prima del "|" (la risposta corretta)
        let correctPart = correctString.components(separatedBy: "|").first ?? ""
        let validAnswers = correctPart.components(separatedBy: ",")
            .map { $0.lowercased().trimmingCharacters(in: .whitespaces) }
        
        if validAnswers.contains(userInput.lowercased().trimmingCharacters(in: .whitespaces)) {
            next()
        }
    }
    
    private func handleDrop(_ providers: [NSItemProvider], _ correct: String) -> Bool {
        guard let provider = providers.first else { return false }
        provider.loadObject(ofClass: NSString.self) { (string, _) in
            DispatchQueue.main.async {
                if let dropped = string as? String, dropped.lowercased() == correct.lowercased() {
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
                prepareRound()
            } else {
                onComplete()
                dismiss()
            }
        }
    }
    
    private var progressHeader: some View {
        HStack {
            ForEach(0..<esercizi.count, id: \.self) { i in
                Capsule().fill(i <= currentIndex ? Color(red: 182/255, green: 23/255, blue: 45/255) : Color.gray.opacity(0.2))
                    .frame(height: 6)
            }
        }.padding()
    }
}
