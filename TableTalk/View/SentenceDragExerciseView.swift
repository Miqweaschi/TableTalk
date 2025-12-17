import SwiftUI
import UniformTypeIdentifiers

struct SentenceDragExerciseView: View {
    let esercizi: [Esercizio<EsercizioContent, EsercizioContent>]
    let onCorrect: () -> Void
    
    @State private var index = 0
    @State private var dropped: [Int: String] = [:]
    @State private var pool: [String] = []
    @Environment(\.dismiss) var dismiss
    
    // Costanti di stile
    let mainColor = Color(red: 182/255, green: 23/255, blue: 45/255)

    var body: some View {
        VStack(spacing: 20) {
            // Header
            ProgressView(value: Double(index + 1), total: Double(esercizi.count))
                .tint(mainColor).padding()
            
            Text("Completa la frase").font(.title2).bold()

            if index < esercizi.count {
                let current = esercizi[index]
                
                // Area Frase
                ScrollView {
                    renderSentence(current)
                        .padding().frame(maxWidth: .infinity)
                        .background(.white).cornerRadius(16).shadow(radius: 5)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                // Area Parole (Pool)
                VStack(spacing: 12) {
                    ForEach(pool, id: \.self) { word in
                        if !dropped.values.contains(word) {
                            WordCard(text: word, color: mainColor)
                        }
                    }
                }
                .padding(.horizontal, 40).padding(.bottom, 20)
                .animation(.spring(), value: dropped) // Aggiunge fluidità
            }
        }
        .background(Color(red: 255/255, green: 247/255, blue: 238/255))
        .onAppear(perform: setup)
    }
    
    @ViewBuilder
    func renderSentence(_ ex: Esercizio<EsercizioContent, EsercizioContent>) -> some View {
        let parts = ex.questionText.components(separatedBy: "___")
        FlowLayout(spacing: 4) {
            ForEach(parts.indices, id: \.self) { i in
                ForEach(parts[i].components(separatedBy: " "), id: \.self) { word in
                    if !word.isEmpty { Text(word).font(.title3).fixedSize() }
                }
                if i < parts.count - 1 {
                    DropZone(word: dropped[i]) { handleDrop($0, i, ex) }
                }
            }
        }
    }
    
    func setup() {
        dropped.removeAll()
        // Logica compatta: unisce risposte corrette e distrattori, pulisce spazi e mischia
        let parts = esercizi[index].answerText.components(separatedBy: "|")
        let allWords = parts.joined(separator: ",").components(separatedBy: ",")
        pool = allWords.map { $0.trimmingCharacters(in: .whitespaces) }.shuffled()
    }
    
    func handleDrop(_ text: String, _ i: Int, _ ex: Esercizio<EsercizioContent, EsercizioContent>) {
        let correctList = ex.answerText.components(separatedBy: "|")[0].components(separatedBy: ",")
        guard i < correctList.count else { return }
        
        let cleanDrop = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let cleanCorrect = correctList[i].trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if cleanDrop == cleanCorrect {
            dropped[i] = text
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            
            if dropped.count == correctList.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if index + 1 < esercizi.count { index += 1; setup() }
                    else { onCorrect(); dismiss() }
                }
            }
        } else {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
}

// MARK: - Subviews
struct WordCard: View {
    let text: String
    let color: Color
    var body: some View {
        Text(text).font(.headline).bold().foregroundColor(.white)
            .padding(.vertical, 12).frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 12).fill(color).shadow(radius: 2, y: 2))
            .onDrag { NSItemProvider(object: text as NSString) }
    }
}

struct DropZone: View {
    let word: String?
    let onDrop: (String) -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6]))
                .foregroundColor(word == nil ? .gray.opacity(0.5) : .green)
                .background(word != nil ? Color.green.opacity(0.1) : .clear)
            if let w = word { Text(w).bold().foregroundColor(.green).padding(.horizontal, 8) }
        }
        .frame(minWidth: 80, minHeight: 40).fixedSize()
        .contentShape(Rectangle())
        .onDrop(of: [UTType.plainText], isTargeted: nil) { providers in
            providers.first?.loadObject(ofClass: NSString.self) { s, _ in
                if let str = s as? String { DispatchQueue.main.async { onDrop(str) } }
            }
            return true
        }
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let w = proposal.width ?? (UIScreen.main.bounds.width - 60)
        var h: CGFloat = 0, rW: CGFloat = 0, rH: CGFloat = 0
        for v in subviews {
            let s = v.sizeThatFits(.unspecified)
            if rW + s.width > w { h += rH + spacing; rW = s.width + spacing; rH = s.height }
            else { rW += s.width + spacing; rH = max(rH, s.height) }
        }
        return CGSize(width: w, height: h + rH)
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX, y = bounds.minY, rH: CGFloat = 0
        for v in subviews {
            let s = v.sizeThatFits(.unspecified)
            if x + s.width > bounds.maxX { x = bounds.minX; y += rH + spacing; rH = 0 }
            v.place(at: CGPoint(x: x, y: y), proposal: .unspecified)
            x += s.width + spacing; rH = max(rH, s.height)
        }
    }
}
