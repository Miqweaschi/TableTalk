//
//  Model.swift
//  TableTalk
//
//  Created by AFP PAR 21 on 05/12/25.
//

import Foundation
import Combine

struct Utente {
    let name : String
    
    func getName() -> String {
        return name
    }
}


// This struct rappresent a single Lesson
struct Lesson : Hashable {
    var title: String
    var number: String
    var argomenti: [Int:String]
    var id = UUID()
    
    init(title: String = "",
         number: String = "1",
         argomenti: [Int:String] = [1: ""]) {
        self.title = title
        self.number = number
        self.argomenti = argomenti
    }
}

class Model : ObservableObject {
    // argomenti lezione 1
    static let argsL1: [Int:String] = [
        1: "Saluti iniziali",
        2: "Saluti finali",
        3: "Esercizi finali"
    ]
    
    static let argsL2: [Int:String] = [
        1: "Saluti iniziali",
        2: "Saluti finali",
        3: "Esercizi finali"
    ]
    static let argsL3: [Int:String] = [
        1: "Saluti iniziali",
        2: "Saluti finali",
        3: "Esercizi finali"
    ]
    
    static let argsL4: [Int:String] = [
        1: "Saluti iniziali",
        2: "Saluti finali",
        3: "Esercizi finali"
    ]
    
    static let argsL5: [Int:String] = [
        1: "Saluti iniziali",
        2: "Saluti finali",
        3: "Esercizi finali"
    ]
    
    static let argsL6: [Int:String] = [
        1: "Saluti iniziali",
        2: "Saluti finali",
        3: "Esercizi finali"
    ]
    
    

    // lessonList.lezione_specifica.argomenti
    // add here new lessons
    let lessonsList = [
        Lesson(title: "Welcome", number: "1", argomenti: argsL1),
        Lesson(title: "Numbers", number: "2",argomenti: argsL2),
        Lesson(title: "Kitchen", number: "3",argomenti: argsL3),
        Lesson(title: "Ingredients", number: "4",argomenti: argsL4),
        Lesson(title: "Advanced", number: "5",argomenti: argsL5),
        Lesson(title: "Advanced", number: "6",argomenti: argsL6),
    ]
}
