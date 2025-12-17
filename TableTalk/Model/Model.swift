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
            // --- I TUOI 3 ESERCIZI ORIGINALI ---
            Esercizio(.text("This caprese salad is made of ___ and ___"), .text("Tomato, Mozzarella | Ham, Bread")),
            
            Esercizio(.text("The pizza ___ mushrooms and cheese"), .text("has | is, are")),
            
            Esercizio(.text("Can I add ___ and ___ to my salad?"), .text("Oil, Salt | Sugar, Milk")),

            Esercizio(.text("Carbonara pasta is made with ___ and ___"), .text("Eggs, Bacon | Fish, Tomato")),
            
            Esercizio(.text("Excuse me, I need a ___ for my soup."), .text("Spoon | Fork, Knife")),
            
            Esercizio(.text("Would you like still or ___ water?"), .text("Sparkling | Spicy, Sweet")),
            
            Esercizio(.text("I would like my steak ___, please."), .text("Medium | Raw, Blue")),
            
            Esercizio(.text("I will have a glass of ___ wine with the meat."), .text("Red | Green, Salty")),
            
            Esercizio(.text("Tiramisu is made of ___ and ___"), .text("Coffee, Mascarpone | Tea, Cheddar")),
            
            Esercizio(.text("The burger comes with a side of ___"), .text("Fries | Soup, Pasta"))
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
        
        
        // 10 esercizi relativi al primo bottone della prima lezione
        static let l2b2: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
            // Prima del '|' le risposte giuste, dopo il '|' i distrattori
            Esercizio(.text("I'm allergic to ___, so I can't eat bread, pasta or pizza."), .text("Gluten | Nickel, Soy")),
            Esercizio(.text("She has a ___ allergy, so she can't drink milk."), .text("Dairy | Peanut, Fish")),
            Esercizio(.text("I have a ___ intolerance, so I can't drink milk."), .text("Lactose | Sugar, Peanut")),
            Esercizio(.text("He has a ___ allergy, so he shouldn't eat almonds or walnuts."), .text("Nut | Shellfish, Egg")),
            Esercizio(.text("I have a ___ allergy, so I can't eat prawns or lobster."), .text("Shellfish | Dairy, Wheat")),
            Esercizio(.text("They are allergic to ___, so they use honey instead of sugar."), .text("Fructose | Caffeine, Gluten")),
            Esercizio(.text("She has an ___ allergy, so she avoids mayonnaise and omelettes."), .text("Egg | Soy, Nut")),
            Esercizio(.text("My brother is allergic to ___, so he never eats tofu or edamame."), .text("Soy | Nickel, Dairy")),
            Esercizio(.text("Since I have a ___ allergy, I always check the ingredients in chocolate for traces of legumes."), .text("Peanut | Fish, Wheat")),
            Esercizio(.text("He is allergic to ___, so he can't eat salmon or tuna."), .text("Fish | Shellfish, Egg")),
        ])
        

        static let mixEserciziL1: Esercizi<EsercizioContent, EsercizioContent> = Esercizi(items: [
            
            Esercizio(.text("How do you say 'aglio' in English?"), .text("Garlic")),
            
            
            Esercizio(.imageAsset(path: "Oil"), .text("Oil")),
            
            
            Esercizio(.text("this pizza have ___? (funghi)"), .text("Mushrooms")),
            
            
            Esercizio(.imageAsset(path: "Tomatoes"), .text("Tomatoes")),
            
            
            Esercizio(.text("How do you say 'pane' in English?"), .text("Bread")),
            
            
            Esercizio(.imageAsset(path: "cheese"), .text("Mozzarella")),
            
            
            Esercizio(.text("How do you say 'pepe' in English?"), .text("Pepper")),
            
            
            Esercizio(.imageAsset(path: "Carrots"), .text("Carrots")),

            
            Esercizio(.text("We have fresh ___ of the day. (pesce)"), .text("Fish")),

        
            Esercizio(.imageAsset(path: "Meat"), .text("Meat"))

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
            
                Argomento(number: "3", content: "Test finale", completed: false, esercizi: Model.mixEserciziL1),
            ])
            
            
            self.argsL2 = Argomenti(items: [
                Argomento(number: "1", content: "Saluti ", completed: false, esercizi: Model.l2b1_drag),
                
                Argomento(number: "2", content: "Presentazioni", completed: false, esercizi: Model.l2b2),
                
                Argomento(number: "3", content: "Test finale", completed: false, esercizi: Model.mixEserciziL1),
            ])
            
            
            
            
            self.lessonsList = [
                Lesson(title: "Menù", number: "1", argomenti: self.argsL1),
                Lesson(title: "Service", number: "2", argomenti: self.argsL2),
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
        
// Aggiungi queste estensioni per evitare gli "switch" o "if case" nelle View
extension Esercizio {
    // Restituisce il nome dell'immagine se presente, altrimenti stringa vuota
    var imageName: String {
        if let content = question as? EsercizioContent, case .imageAsset(let path) = content {
            return path
        }
        return ""
    }
    
    // Restituisce il testo della risposta pulito
    var textAnswer: String {
        if let content = answer as? EsercizioContent, case .text(let t) = content {
            return t
        }
        return ""
    }
}

extension Esercizio {
    // Se è una domanda di testo, mi ridà la stringa, altrimenti nil
    var questionString: String? {
        if let content = question as? EsercizioContent, case .text(let t) = content {
            return t
        }
        return nil
    }
}


