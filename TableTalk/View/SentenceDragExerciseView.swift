import SwiftUI
import UniformTypeIdentifiers

struct SentenceDragExerciseView: View {
    let esercizi: [Esercizio<EsercizioContent, EsercizioContent>]
    let onCorrect: () -> Void
    
    @State private var currentIndex = 0
    @State private var droppedWords: [Int: String] = [:]
    @State private var availableWords: [String] = []
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 30) {
            // --- BARRA DI PROGRESSO (Stile MatchingExerciseView) ---
            VStack(spacing: 6) {
                ProgressView(value: Double(currentIndex + 1), total: Double(esercizi.count))
                    .tint(Color(red: 182/255, green: 23/255, blue: 45/255))
                    .padding(.horizontal)
                Text("Esercizio \(currentIndex + 1) di \(esercizi.count)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(.top)

            Text("Completa la frase")
                .font(.title2)
                .bold()

            if currentIndex < esercizi.count {
                let attuale = esercizi[currentIndex]

                VStack(spacing: 40) {
                    // --- AREA DELLA FRASE ---
                    renderSentence(attuale.questionText, attuale: attuale)
                        .padding(25)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)

                    // --- AREA PAROLE IN COLONNA ---
                    VStack(spacing: 15) {
                        Text("TRASCINA LE ETICHETTE").font(.subheadline).foregroundColor(.secondary)
                        
                        // Usiamo VStack per metterle una sotto l'altra
                        VStack(spacing: 12) {
                            ForEach(availableWords, id: \.self) { parola in
                                if !droppedWords.values.contains(parola) {
                                    Text(parola)
                                        .bold()
                                        .frame(maxWidth: 200) // Dimensione fissa per eleganza
                                        .padding(.vertical, 12)
                                        .padding(.horizontal, 20)
                                        .background(Color(red: 182/255, green: 23/255, blue: 45/255))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .onDrag { NSItemProvider(object: parola as NSString) }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .id(currentIndex)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 255/255, green: 247/255, blue: 238/255))
        .onAppear(perform: setupCurrentExercise)
    }

    @ViewBuilder
    private func renderSentence(_ sentence: String, attuale: Esercizio<EsercizioContent, EsercizioContent>) -> some View {
        let parti = sentence.components(separatedBy: "___")
        
        FlowLayout(spacing: 10) {
            ForEach(0..<parti.count, id: \.self) { index in
                Text(parti[index])
                    .font(.title3)

                if index < parti.count - 1 {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(droppedWords[index] == nil ? Color.gray.opacity(0.1) : Color.green.opacity(0.2))
                            .frame(minWidth: 100, minHeight: 45)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(droppedWords[index] == nil ? Color.gray.opacity(0.3) : Color.green,
                                            lineWidth: 2)
                            )
                        
                        if let word = droppedWords[index] {
                            Text(word.uppercased())
                                .bold()
                                .foregroundColor(.green)
                        }
                    }
                    .fixedSize()
                    .onDrop(of: [UTType.text], isTargeted: nil) { providers in
                        handleDrop(providers: providers, spaceIndex: index, currentEx: attuale)
                    }
                }
            }
        }
    }

    // Le funzioni setupCurrentExercise, handleDrop e nextExercise rimangono uguali a prima
    private func setupCurrentExercise() {
        droppedWords = [:]
        let attuale = esercizi[currentIndex]
        let parti = attuale.answerText.components(separatedBy: "|")
        let corrette = parti[0].components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        var tutte = corrette
        if parti.count > 1 {
            let distrattori = parti[1].components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            tutte.append(contentsOf: distrattori)
        }
        self.availableWords = tutte.shuffled()
    }

    private func handleDrop(providers: [NSItemProvider], spaceIndex: Int, currentEx: Esercizio<EsercizioContent, EsercizioContent>) -> Bool {
        guard let provider = providers.first else { return false }
        provider.loadObject(ofClass: NSString.self) { (string, _) in
            guard let testo = string as? String else { return }
            DispatchQueue.main.async {
                let parti = currentEx.answerText.components(separatedBy: "|")
                let risposteCorrette = parti[0].components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                if spaceIndex < risposteCorrette.count && testo == risposteCorrette[spaceIndex] {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred() // Vibrazione
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        droppedWords[spaceIndex] = testo
                    }
                    if droppedWords.count == risposteCorrette.count {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { nextExercise() }
                    }
                }
            }
        }
        return true
    }

    private func nextExercise() {
        if currentIndex + 1 < esercizi.count {
            currentIndex += 1
            setupCurrentExercise()
        } else {
            onCorrect()
            dismiss()
        }
    }
}

// --- FLOWLAYOUT (Invariato) ---
struct FlowLayout: Layout {
    var spacing: CGFloat
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        var width: CGFloat = 0; var height: CGFloat = 0; var x: CGFloat = 0; var y: CGFloat = 0; var maxHeight: CGFloat = 0
        for size in sizes {
            if x + size.width > (proposal.width ?? 0) { x = 0; y += maxHeight + spacing; maxHeight = 0 }
            x += size.width + spacing; width = max(width, x); maxHeight = max(maxHeight, size.height); height = max(height, y + maxHeight)
        }
        return CGSize(width: width, height: height)
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX; var y = bounds.minY; var maxHeight: CGFloat = 0
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX { x = bounds.minX; y += maxHeight + spacing; maxHeight = 0 }
            subview.place(at: CGPoint(x: x, y: y), proposal: .unspecified)
            x += size.width + spacing; maxHeight = max(maxHeight, size.height)
        }
    }
}
