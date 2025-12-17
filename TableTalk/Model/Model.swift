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

        // Questa versione forza il controllo sul tipo EsercizioContent
        var questionText: String {
            if let content = question as? EsercizioContent {
                switch content {
                case .text(let t): return t
                case .imageAsset(let path): return path
                }
            }
            return ""
        }
        
        var answerText: String {
            if let content = answer as? EsercizioContent {
                switch content {
                case .text(let t): return t
                case .imageAsset(let path): return path
                }
            }
            return ""
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
        static let l1b2: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
            // Prima del '|' le risposte giuste, dopo il '|' i distrattori
            Esercizio(.text("This caprese salad is made of ___ and ___"), .text("Tomato, Mozzarella | Ham, Bread")),
            Esercizio(.text("The pizza ___ mushrooms and cheese"), .text("has | is, are")),
            Esercizio(.text("Can I add ___ and ___ to my salad?"), .text("Oil, Salt | Sugar, Milk"))
        ])
        
        // 10 esercizi relativi al primo bottone della prima lezione
        static let l2b2: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
            // Prima del '|' le risposte giuste, dopo il '|' i distrattori
            Esercizio(.text("This caprese salad is made of ___ and ___"), .text("Tomato, Mozzarella | Ham, Bread")),
            Esercizio(.text("The pizza ___ mushrooms and cheese"), .text("has | is, are")),
            Esercizio(.text("Can I add ___ and ___ to my salad?"), .text("Oil, Salt | Sugar, Milk"))
        ])
        
        
        // Lezione1Bottone2; immagine con risposta
        static let l1b1_drag: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
            Esercizio(.imageAsset(path: "Oil"), .text("Oil"), done: false),
            Esercizio(.imageAsset(path: "Salad"), .text("Salad"), done: false),
            
            Esercizio(.imageAsset(path: "Cucumbers"), .text("Cucumbers"), done: false),
            Esercizio(.imageAsset(path: "Meat"), .text("Meat"), done: false),
            
            Esercizio(.imageAsset(path: "Salt"), .text("Salt"), done: false),
            Esercizio(.imageAsset(path: "Bread"), .text("Bread"), done: false),
            
            Esercizio(.imageAsset(path: "Carrots"), .text("Carrots"), done: false),
            Esercizio(.imageAsset(path: "cheese"), .text("Mozzarella"), done: false),
            
            Esercizio(.imageAsset(path: "Mushrooms"), .text("Mushrooms"), done: false),
            Esercizio(.imageAsset(path: "Tomatoes"), .text("Tomatoes"), done: false),
        ])
        
        static let l2b1_drag: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
            Esercizio(.imageAsset(path: "Oil"), .text("Oil"), done: false),
            Esercizio(.imageAsset(path: "Salad"), .text("Salad"), done: false),
            
            Esercizio(.imageAsset(path: "Cucumbers"), .text("Cucumbers"), done: false),
            Esercizio(.imageAsset(path: "Meat"), .text("Meat"), done: false),
            
            Esercizio(.imageAsset(path: "Salt"), .text("Salt"), done: false),
            Esercizio(.imageAsset(path: "Bread"), .text("Bread"), done: false),
            
            Esercizio(.imageAsset(path: "Carrots"), .text("Carrots"), done: false),
            Esercizio(.imageAsset(path: "cheese"), .text("Mozzarella"), done: false),
            
            Esercizio(.imageAsset(path: "Mushrooms"), .text("Mushrooms"), done: false),
            Esercizio(.imageAsset(path: "Tomatoes"), .text("Tomatoes"), done: false),
        ])
        
        

        static let mixEsercizi: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
            // Tipo 1: Domanda testuale (Scrittura/Completamento)
            Esercizio(.text("How do you say 'Il conto' in English?"), .text("The bill")),
            
            // Tipo 2: Immagine (Drag & Drop)
            Esercizio(.imageAsset(path: "Oil"), .text("Oil")),
            
            // Tipo 1: Domanda testuale
            Esercizio(.text("Is the pizza ___? (calda)"), .text("hot")),
            
            // Tipo 2: Immagine
            Esercizio(.imageAsset(path: "Tomatoes"), .text("Tomatoes"))
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
                Argomento(number: "1", content: "Saluti iniziali", completed: false, esercizi: Model.l1b1_drag),
                
                Argomento(number: "2", content: "Presentazioni", completed: false, esercizi: Model.l1b2),
            
                Argomento(number: "3", content: "Test finale", completed: false, esercizi: Model.mixEsercizi),
            ])
            
            
            self.argsL2 = Argomenti(items: [
                Argomento(number: "1", content: "Saluti ", completed: false, esercizi: Model.l2b1_drag),
                
                Argomento(number: "2", content: "Presentazioni", completed: false, esercizi: Model.l2b2),
                
                Argomento(number: "3", content: "Test finale", completed: false, esercizi: Model.mixEsercizi),
            ])
            
            
            
            
            self.lessonsList = [
                Lesson(title: "Menù", number: "1", argomenti: self.argsL1),
                Lesson(title: "Numbers", number: "2", argomenti: self.argsL2),
                //Lesson(title: "Kitchen", number: "3", argomenti: self.argsL1),
                //Lesson(title: "Ingredients", number: "4", argomenti: self.argsL1),
                //Lesson(title: "Advanced", number: "5", argomenti: self.argsL1),
                //Lesson(title: "Advanced", number: "6", argomenti: self.argsL1)
            ]
        }
        
        @Published var simulationDialogue: [DialogueStep] = [
            DialogueStep(customerLine: "Hello, are you open?", expectedAnswer: "Hello, yes. Welcome!"),
            DialogueStep(customerLine: "We would lika a table.", expectedAnswer: "For how many?"),
            DialogueStep(customerLine: "We are four.", expectedAnswer: "Follow me, please")
        ]
        
        // Variabile per tracciare il progresso globale (da usare nella MainHomeView)
        @Published var totalProgress: Double = 0.0
    }
        
        


