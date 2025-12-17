import SwiftUI
import UniformTypeIdentifiers

struct MatchingExerciseView: View {
    let esercizi: [Esercizio<EsercizioContent, EsercizioContent>]
    let onComplete: () -> Void
    
    // Gestione dei gruppi (coppie)
    @State private var currentPairIndex: Int = 0
    @State private var completedInCurrentPair: Set<UUID> = []
    @State private var shuffledAnswers: [String] = []
    @State private var lastResultPerTarget: [UUID: Bool?] = [:]
    
    @Environment(\.dismiss) var dismiss

    // Calcoliamo i gruppi di 2
    private var pairs: [[Esercizio<EsercizioContent, EsercizioContent>]] {
        stride(from: 0, to: esercizi.count, by: 2).map {
            Array(esercizi[$0..<min($0 + 2, esercizi.count)])
        }
    }

    var body: some View {
        VStack(spacing: 30) {
            // Barra di progresso gruppi
            VStack(spacing: 6) {
                ProgressView(value: Double(currentPairIndex + 1), total: Double(pairs.count))
                    .tint(Color(red: 182/255, green: 23/255, blue: 45/255))
                    .padding(.horizontal)
                Text("Gruppo \(currentPairIndex + 1) di \(pairs.count)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(.top)

            Text("Abbina le parole alle immagini")
                .font(.title2)
                .bold()

            if currentPairIndex < pairs.count {
                let currentPair = pairs[currentPairIndex]

                // --- AREA IMMAGINI (GRUPPO CORRENTE) ---
                HStack(spacing: 30) {
                    ForEach(currentPair, id: \.id) { ex in
                        VStack(spacing: 15) {
                            let result = lastResultPerTarget[ex.id] ?? nil
                            ZStack {
                                if case let .imageAsset(path) = ex.question {
                                    Image(path)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 140)
                                        .clipped()
                                        .cornerRadius(15)
                                }

                                if completedInCurrentPair.contains(ex.id) {
                                    Color.green.opacity(0.3).cornerRadius(15)
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 40))
                                } else if result == false {
                                    Color.red.opacity(0.25).cornerRadius(15)
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 36))
                                }
                            }
                            .frame(width: 140, height: 140)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(
                                        completedInCurrentPair.contains(ex.id)
                                        ? Color.green
                                        : ((result == false) ? Color.red : Color.gray.opacity(0.3)),
                                        lineWidth: 3
                                    )
                            )
                            .onDrop(of: [UTType.text], isTargeted: nil) { providers in
                                handleDrop(providers: providers, targetEx: ex)
                            }

                            if completedInCurrentPair.contains(ex.id), case let .text(answerText) = ex.answer {
                                Text(answerText.uppercased()).bold().foregroundColor(.green)
                            } else {
                                Text("").font(.caption).foregroundColor(.gray)
                            }
                        }
                    }
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))

                //Spacer()

                // --- AREA PAROLE (GRUPPO CORRENTE) ---
                VStack(spacing: 15) {
                    Text("TRASCINA LE ETICHETTE").font(.subheadline)
                    HStack(spacing: 15) {
                        ForEach(shuffledAnswers, id: \.self) { answer in
                            Text(answer)
                                .bold()
                                .padding(.vertical, 12)
                                .padding(.horizontal, 20)
                                .background(Color(red: 182/255, green: 23/255, blue: 45/255))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .onDrag { NSItemProvider(object: answer as NSString) }
                        }
                    }
                }
                .padding(.bottom, 50)
            }
            
        }
        .background(Color(red: 255/255, green: 247/255, blue: 238/255))
        .onAppear { loadCurrentPair() }
    }

    // Carica le risposte mescolate solo per la coppia corrente
    private func loadCurrentPair() {
        let currentPair = pairs[currentPairIndex]
        let answers = currentPair.compactMap { (ex) -> String? in
            if case let .text(t) = ex.answer { return t }
            return nil
        }
        shuffledAnswers = answers.shuffled()
        completedInCurrentPair = []
        lastResultPerTarget = [:]
    }

    private func handleDrop(providers: [NSItemProvider], targetEx: Esercizio<EsercizioContent, EsercizioContent>) -> Bool {
            guard let provider = providers.first else { return false }
            
            provider.loadObject(ofClass: NSString.self) { (string, _) in
                guard let droppedText = string as? String else { return }
                
                DispatchQueue.main.async {
                    if case let .text(correct) = targetEx.answer, droppedText.lowercased() == correct.lowercased() {
                        withAnimation(.spring()) {
                            completedInCurrentPair.insert(targetEx.id)
                            shuffledAnswers.removeAll { $0 == droppedText }
                            lastResultPerTarget[targetEx.id] = true
                        }

                        if completedInCurrentPair.count == pairs[currentPairIndex].count {
                            let isLastPair = (currentPairIndex + 1 >= pairs.count)
                            if isLastPair {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    onComplete()
                                    dismiss()
                                }
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                    withAnimation {
                                        currentPairIndex += 1
                                        loadCurrentPair()
                                    }
                                }
                            }
                        }
                    } else {
                        withAnimation(.easeIn(duration: 0.15)) {
                            lastResultPerTarget[targetEx.id] = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            withAnimation(.easeOut(duration: 0.2)) {
                                lastResultPerTarget[targetEx.id] = nil
                            }
                        }
                    }
                }
            }
            return true
        }
}
