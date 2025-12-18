import SwiftUI
import UniformTypeIdentifiers

// MARK: - CONFIGURAZIONE
private let appRed = Color(red: 182/255, green: 23/255, blue: 45/255)
// Definiamo il colore di sfondo uguale all'esempio per coerenza
private let appBackground = Color(red: 255/255, green: 247/255, blue: 238/255)
private let extraWords = ["Wine", "Water", "Menu", "Table", "Fork", "Knife", "Plate", "Glass"]

struct MixedExerciseView: View {
    let esercizi: [Esercizio<EsercizioContent, EsercizioContent>]
    let onComplete: () -> Void
    @State private var idx = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            // Barra Progresso
            HStack {
                ForEach(0..<esercizi.count, id: \.self) { i in
                    Capsule()
                        .fill(i <= idx ? appRed : .gray.opacity(0.2))
                        .frame(height: 6)
                }
            }.padding()
            
            if idx < esercizi.count {
                let ex = esercizi[idx]
                // Switch automatico
                if let q = ex.questionString {
                    FillInBlankView(question: q, answer: ex.textAnswer, next: next)
                } else {
                    ImageDropView(img: ex.imageName, answer: ex.textAnswer, next: next)
                }
            } else {
                Spacer() // Spacer di sicurezza nel caso idx vada fuori range
            }
        }
        // MODIFICA IMPORTANTE: Forza la vista a occupare tutto lo schermo prima di applicare lo sfondo
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(appBackground)
        .animation(.easeInOut, value: idx)
    }
    
    func next() {
        if idx + 1 < esercizi.count { idx += 1 } else { onComplete(); dismiss() }
    }
}

// MARK: - ESERCIZIO 1: RIEMPI GLI SPAZI
struct FillInBlankView: View {
    let question: String, answer: String
    let next: () -> Void
    @State private var input = ""
    @State private var opts: [String] = []
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Completa la frase").font(.headline).foregroundColor(.secondary)
            Text(question).font(.title2).bold().multilineTextAlignment(.center)
            
            TextField("Scrivi qui...", text: $input)
                .textFieldStyle(.roundedBorder).padding(.horizontal).autocorrectionDisabled()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(opts, id: \.self) { w in
                    Button(w) { input = w }
                        .padding(10).background(.white).cornerRadius(8).shadow(radius: 1)
                }
            }.padding()
            
            Button("Verifica") {
                let valid = answer.components(separatedBy: "|")[0].components(separatedBy: ",")
                if valid.map({$0.lowercased().trim()}).contains(input.lowercased().trim()) { next() }
            }
            .buttonStyle(.borderedProminent).tint(appRed)
            
            Spacer() // MODIFICA: Spinge il contenuto in alto per riempire la pagina
        }
        .onAppear { opts = setupOptions(answer: answer, limit: 6) }
    }
}

// MARK: - ESERCIZIO 2: DRAG & DROP IMMAGINE
struct ImageDropView: View {
    let img: String, answer: String
    let next: () -> Void
    @State private var opts: [String] = []
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Trascina la parola sull'immagine").font(.headline).foregroundColor(.secondary)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20).fill(.white).shadow(radius: 5)
                Image(img).resizable().scaledToFit().padding(10)
            }
            .frame(width: 250, height: 250)
            .onDrop(of: [.text], isTargeted: nil) { providers in
                providers.first?.loadObject(ofClass: NSString.self) { item, _ in
                    if let txt = item as? String, txt.isEqual(to: answer) {
                        DispatchQueue.main.async { next() }
                    }
                }
                return true
            }
            
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 15) {
                ForEach(opts, id: \.self) { w in
                    Text(w).padding().frame(maxWidth: .infinity)
                        .background(appRed).foregroundColor(.white).cornerRadius(10)
                        .onDrag { NSItemProvider(object: w as NSString) }
                }
            }.padding(.horizontal)
            
            Spacer() // MODIFICA: Spinge il contenuto in alto per riempire la pagina
        }
        .onAppear { opts = setupOptions(answer: answer, limit: 4) }
    }
}

// MARK: - HELPERS
private func setupOptions(answer: String, limit: Int) -> [String] {
    let parts = answer.components(separatedBy: "|")
    let correct = parts[0].components(separatedBy: ",").map { $0.trim() }[0]
    
    var pool: [String] = []
    if parts.count > 1 {
        pool = parts[1].components(separatedBy: ",").map { $0.trim() }
    } else {
        pool = extraWords.filter { !$0.isEqual(to: correct) }
    }
    return ([correct] + pool.shuffled().prefix(limit - 1)).shuffled()
}

extension String {
    func trim() -> String { self.trimmingCharacters(in: .whitespacesAndNewlines) }
    func isEqual(to other: String) -> Bool { self.trim().lowercased() == other.trim().lowercased() }
}
