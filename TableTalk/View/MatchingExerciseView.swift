import SwiftUI
import UniformTypeIdentifiers

struct MatchingExerciseView: View {
    let esercizi: [Esercizio<EsercizioContent, EsercizioContent>]
    let onComplete: () -> Void
    @Environment(\.dismiss) var dismiss
    
    @State private var pIdx = 0 // Indice pagina
    @State private var solved: Set<UUID> = []
    @State private var tags: [String] = []
    @State private var errorId: UUID?
    
    // Calcola gli esercizi correnti (max 2)
    var batch: [Esercizio<EsercizioContent, EsercizioContent>] {
        let start = pIdx * 2
        return Array(esercizi[start..<min(start + 2, esercizi.count)])
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Progress Bar
            ProgressView(value: Double(pIdx + 1), total: Double((esercizi.count + 1) / 2))
                .tint(Color(red: 182/255, green: 23/255, blue: 45/255)).padding()
            
            Text("Abbina le parole").font(.title2).bold()
            
            // Area Immagini (Drop Zones)
            HStack(spacing: 30) {
                ForEach(batch, id: \.id) { ex in
                    DropSlot(
                        ex: ex,
                        state: solved.contains(ex.id) ? .ok : (errorId == ex.id ? .err : .none),
                        onDrop: { handleDrop(txt: $0, ex: ex) }
                    )
                }
            }.padding()
            
            Spacer()
            
            // Area Parole (Draggable)
            HStack(spacing: 15) {
                ForEach(tags, id: \.self) { tag in DraggableTag(text: tag) }
            }.padding(.bottom, 50).animation(.default, value: tags)
        }
        .background(Color(red: 255/255, green: 247/255, blue: 238/255))
        .onAppear(perform: loadTags)
    }
    
    func loadTags() {
        tags = batch.map { $0.textAnswer }.shuffled()
        solved.removeAll()
    }
    
    func handleDrop(txt: String, ex: Esercizio<EsercizioContent, EsercizioContent>) {
        if txt.lowercased() == ex.textAnswer.lowercased() {
            withAnimation {
                solved.insert(ex.id)
                tags.removeAll { $0 == txt }
            }
            // Controllo fine pagina/esercizio
            if solved.count == batch.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (pIdx + 1) * 2 < esercizi.count {
                        pIdx += 1; loadTags()
                    } else {
                        onComplete(); dismiss()
                    }
                }
            }
        } else {
            withAnimation { errorId = ex.id }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { withAnimation { errorId = nil } }
        }
    }
}

// Drag
struct DraggableTag: View {
    let text: String
    var body: some View {
        Text(text).bold().padding().background(Color(red: 182/255, green: 23/255, blue: 45/255)).foregroundColor(.white).cornerRadius(10)
        
            .onDrag { NSItemProvider(object: text as NSString) }
    }
}

enum SlotState { case none, ok, err }

struct DropSlot: View {
    let ex: Esercizio<EsercizioContent, EsercizioContent>
    let state: SlotState
    let onDrop: (String) -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Image(ex.imageName)
                    .resizable()
                    .scaledToFill()
                    //.scaleEffect(1)
                    .frame(width: 180, height: 180)
                    .offset(y: -35)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                
                // Overlay stati (Verde/Rosso)
                if state != .none {
                    Color(state == .ok ? .green : .red).opacity(0.4)
                    Image(systemName: state == .ok ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.largeTitle).foregroundColor(.white)
                }
            } .frame(width: 180, height: 180)
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(state == .ok ? .green : (state == .err ? .red : .gray.opacity(0.3)), lineWidth: 3)
            )
            .onDrop(of: [.text], isTargeted: nil) { providers in
                providers.first?.loadObject(ofClass: NSString.self) { s, _ in
                    if let txt = s as? String { DispatchQueue.main.async { onDrop(txt) } }
                }
                return true
            }
            
            Text(state == .ok ? ex.textAnswer.uppercased() : " ").font(.headline).foregroundColor(.green)
        }
    }
}
