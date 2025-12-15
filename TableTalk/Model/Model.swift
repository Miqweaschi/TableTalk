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

class Model: ObservableObject {
    // 10 esercizi relativi al primo bottone della prima lezione
    static let l1b1: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
        Esercizio(.text("Come ti chiami?"), .text("Gay"), done: false),
        Esercizio(.text("Come ti chiami?"), .text("Paolo"), done: false),
        Esercizio(.text("Come ti chiami?"), .text("Paolo"), done: false),
        Esercizio(.text("Come ti chiami?"), .text("Paolo"), done: false),
        Esercizio(.text("Come ti chiami?"), .text("Paolo"), done: false),
        Esercizio(.text("Come ti chiami?"), .text("Paolo"), done: false),
        Esercizio(.text("Come ti chiami?"), .text("Paolo"), done: false),
        Esercizio(.text("Come ti chiami?"), .text("Paolo"), done: false),
        Esercizio(.text("Come ti chiami?"), .text("Paolo"), done: false),
        Esercizio(.text("Come ti chiami?"), .text("Paolo"), done: false),
    ])
    
    // Lezione1Bottone2; immagine con risposta
    static let l1b2: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine carne"), .text("carne"), done: false),
        
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
        Esercizio(.imageAsset(path: "path immagine pasta"), .text("pasta"), done: false),
    ])
    
    // Varie lezioni
    let argsL1: Argomenti
    
    // Lista lezioni
    let lessonsList: [Lesson]
    
    init() {
        self.argsL1 = Argomenti(items: [
            Argomento(number: "1", content: "Saluti iniziali", completed: false, esercizi: Model.l1b1),
            Argomento(number: "2", content: "Presentazioni", completed: false),
            Argomento(number: "3", content: "Esercizi finali", completed: false)
        ])
        
        self.lessonsList = [
            Lesson(title: "Welcome", number: "1", argomenti: self.argsL1),
            Lesson(title: "Numbers", number: "2", argomenti: self.argsL1),
            Lesson(title: "Kitchen", number: "3", argomenti: self.argsL1),
            Lesson(title: "Ingredients", number: "4", argomenti: self.argsL1),
            Lesson(title: "Advanced", number: "5", argomenti: self.argsL1),
            Lesson(title: "Advanced", number: "6", argomenti: self.argsL1)
        ]
    }
}
