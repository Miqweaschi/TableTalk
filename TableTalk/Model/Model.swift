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

// Un singolo argomento: traccia completamento
struct Argomento: Hashable, Identifiable {
    var id = UUID()
    var number: String      // numero del singolo argomento
    var content: String     // contenuto dell'argomento
    var completed: Bool     // argomento completato o no
    
    init(number: String = "", content: String = "", completed: Bool = false) {
        self.number = number
        self.content = content
        self.completed = completed
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
    static let argsL1 = Argomenti(items: [
        Argomento(number: "1", content: "Saluti iniziali", completed: false),
        Argomento(number: "2", content: "Presentazioni", completed: false),
        Argomento(number: "3", content: "Esercizi finali", completed: false)
    ])
    
    // Lista lezioni
    let lessonsList: [Lesson] = [
        Lesson(title: "Welcome", number: "1", argomenti: Model.argsL1),
        Lesson(title: "Numbers", number: "2", argomenti: Model.argsL1),
        Lesson(title: "Kitchen", number: "3", argomenti: Model.argsL1),
        Lesson(title: "Ingredients", number: "4", argomenti: Model.argsL1),
        Lesson(title: "Advanced", number: "5", argomenti: Model.argsL1),
        Lesson(title: "Advanced", number: "6", argomenti: Model.argsL1)
    ]
}
