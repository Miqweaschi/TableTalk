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
struct Lesson {
    var title: String
    var number: Int
    var id = UUID()
    
    init(title: String = "", number: Int = 1) {
        self.title = title
        self.number = number
    }
}

class Model:ObservableObject {
    // add here new lessons
    let lessonsList = [
        Lesson(title: "Welcome", number: 1),
        Lesson(title: "Numbers", number: 2),
        Lesson(title: "Kitchen", number: 3),
        Lesson(title: "Ingredients", number: 4),
        Lesson(title: "Advanced", number: 5),
        Lesson(title: "Advanced", number: 6),
    ]
}
