//
//  Model.swift
//  TableTalk
//
//  Created by AFP PAR 21 on 05/12/25.
//

import Foundation
import Combine

struct Utente {
    let name: String
    
    func getName() -> String {
        return name
    }
}


// Questa struct contiene un singolo esercizio
struct Esercizio<Q: Hashable, A: Hashable>: Hashable {
    var id = UUID()
    var question: Q
    var answer: A
    var done: Bool
    
    init(_ question: Q, _ answer: A, done: Bool = false) {
        self.question = question
        self.answer = answer
        self.done = done
    }
}

// Lista degli esercizi di un singolo argomento
struct Esercizi<Q: Hashable, A: Hashable>: Hashable {
    var items: [Esercizio<Q, A>]
    
    init(items: [Esercizio<Q, A>] = []) {
        self.items = items
    }
}

// Contenuto tipico per domanda/risposta: testo o immagine asset
enum EsercizioContent: Hashable {
    case text(String)
    case imageAsset(path: String)
}

// Un singolo argomento: traccia completamento
struct Argomento: Hashable, Identifiable {
    var id = UUID()
    var number: String      // numero del singolo argomento
    var content: String     // contenuto dell'argomento
    var completed: Bool     // argomento completato o no
    var esercizi: Esercizi<EsercizioContent, EsercizioContent>
    
    init(number: String = "", content: String = "", completed: Bool = false, esercizi: Esercizi<EsercizioContent, EsercizioContent> = Esercizi()) {
        self.number = number
        self.content = content
        self.completed = completed
        self.esercizi = esercizi
    }
}

// Collezione di argomenti per una lezione
struct Argomenti: Hashable {
    var items: [Argomento]
    
    init(items: [Argomento] = []) {
        self.items = items
    }
}

// Questa struttura rappresenta una singola lezione
struct Lesson: Hashable, Identifiable {
    var id = UUID()
    var title: String
    var number: String
    var argomenti: Argomenti
    
    init(title: String = "", number: String = "1", argomenti: Argomenti = Argomenti()) {
        self.title = title
        self.number = number
        self.argomenti = argomenti
    }
}

// Aggiungi questa struct fuori dalla classe nel file Model.swift
struct DialogueStep: Hashable, Identifiable {
    let id = UUID()
    let customerLine: String
    let expectedAnswer: String
}


    

class Model: ObservableObject {
    // 10 esercizi relativi al primo bottone della prima lezione
    static let l1b1: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
        Esercizio(.text("Come ti chiami?"), .text("Gay"), done: false),
        Esercizio(.text("Come stai oggi?"), .text("Bene"), done: false),
        Esercizio(.text("Quanti anni hai?"), .text("20"), done: false),
        Esercizio(.text("Che giorno è?"), .text("Lunedi"), done: false),
        Esercizio(.text("Che mese è?"), .text("Dicembre"), done: false),
        Esercizio(.text("Che anno è?"), .text("2025"), done: false),
        Esercizio(.text("Dove sei?"), .text("IOS"), done: false),
        Esercizio(.text("Posso entrare?"), .text("NO"), done: false),
        Esercizio(.text("Posso uscire?"), .text("NO"), done: false),
        Esercizio(.text("Posso salire?"), .text("Aldo Baglio"), done: false),
    ])
    
    static let l1b2: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
        Esercizio(.text("AAAAA"), .text("Gay"), done: false),
        Esercizio(.text("Come stai oggi?"), .text("Bene"), done: false),
        Esercizio(.text("Quanti anni hai?"), .text("20"), done: false),
        Esercizio(.text("Che giorno è?"), .text("Lunedi"), done: false),
        Esercizio(.text("Che mese è?"), .text("Dicembre"), done: false),
        Esercizio(.text("Che anno è?"), .text("2025"), done: false),
        Esercizio(.text("Dove sei?"), .text("IOS"), done: false),
        Esercizio(.text("Posso entrare?"), .text("NO"), done: false),
        Esercizio(.text("Posso uscire?"), .text("NO"), done: false),
        Esercizio(.text("Posso salire?"), .text("Aldo Baglio"), done: false),
    ])
    
    // Lezione1Bottone2; immagine con risposta
    static let l1b1_drag: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine carne"), .text("carne"), done: false),
        
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("carne"), done: false),
        
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("carne"), done: false),
        
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("carne"), done: false),
        
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("carne"), done: false),
    ])
    
    static let l1b2_drag: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine carne"), .text("carne"), done: false),
        
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("carne"), done: false),
        
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("carne"), done: false),
        
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("carne"), done: false),
        
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("carne"), done: false),
    ])
    
    static let l1b3_drag: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
        // 1. Scrittura
        Esercizio(.text("Come si dice 'Ciao' in inglese?"), .text("Hello")),
        // 2. Drag & Drop con Scelte
        Esercizio(.imageAsset(path: "pasta"), .text("Pasta")),
        // 3. Scrittura
        Esercizio(.text("Traduci: 'Il ragazzo'"), .text("The boy")),
        // 4. Drag & Drop con Scelte
        Esercizio(.imageAsset(path: "mela"), .text("Apple"))
    ])


    
     
    // Varie lezioni
    let argsL1: Argomenti
    let argsL2: Argomenti
    
    // Lista lezioni
    @Published var lessonsList: [Lesson]
    
    init() {
        // Nel file Model.swift, all'interno di init()
        // In Model.swift -> init()
        self.argsL1 = Argomenti(items: [
            Argomento(number: "1", content: "Saluti iniziali", completed: false, esercizi: Model.l1b1),
            Argomento(number: "2", content: "Presentazioni", completed: false, esercizi: Model.l1b1_drag),
            
            // QUI CREIAMO IL MIX PER IL BOTTONE 3
            Argomento(number: "3", content: "Test finale", completed: false, esercizi: Model.l1b3_drag)
        ])
        
        
        self.argsL2 = Argomenti(items: [
            Argomento(number: "1", content: "Saluti ", completed: false, esercizi: Model.l1b2),
            Argomento(number: "2", content: "Presentazioni", completed: false, esercizi: Model.l1b2_drag),
            
            // QUI CREIAMO IL MIX PER IL BOTTONE 3
            Argomento(number: "3", content: "Test finale", completed: false, esercizi: Esercizi(items: [
                // 1. Scrittura
                Esercizio(.text("Come si dice 'Ciao' in inglese?"), .text("Hello")),
                // 2. Drag & Drop con Scelte
                Esercizio(.imageAsset(path: "pasta"), .text("Pasta")),
                // 3. Scrittura
                Esercizio(.text("Traduci: 'Il ragazzo'"), .text("The boy")),
                // 4. Drag & Drop con Scelte
                Esercizio(.imageAsset(path: "mela"), .text("Apple"))
            ]))
        ])
        
        
        
        
        self.lessonsList = [
            Lesson(title: "Welcoming", number: "1", argomenti: self.argsL1),
            Lesson(title: "Numbers", number: "2", argomenti: self.argsL2),
            //  Lesson(title: "Kitchen", number: "3", argomenti: self.argsL1),
            //  Lesson(title: "Ingredients", number: "4", argomenti: self.argsL1),
            // Lesson(title: "Advanced", number: "5", argomenti: self.argsL1),
            // Lesson(title: "Advanced", number: "6", argomenti: self.argsL1)
        ]
    }
    
    @Published var simulationDialogue: [DialogueStep] = [
        DialogueStep(customerLine: "Buongiorno! Avete un tavolo per due?", expectedAnswer: "si"),
        DialogueStep(customerLine: "Perfetto. Possiamo metterci vicino alla finestra?", expectedAnswer: "certo"),
        DialogueStep(customerLine: "Grazie! Possiamo ordinare subito?", expectedAnswer: "ecco il menu")
    ]
    
    // Variabile per tracciare il progresso globale (da usare nella MainHomeView)
    @Published var totalProgress: Double = 0.0
}
    


    


