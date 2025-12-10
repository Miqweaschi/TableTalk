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
struct Lesson : Hashable{
    var title: String
    var number: String
    var id = UUID()
    
    init(title: String = "", number: String = "1") {
        self.title = title
        self.number = number
    }
}

class Model : ObservableObject {
    // add here new lessons
    let lessonsList = [
        Lesson(title: "Welcome", number: "1"),
        Lesson(title: "Numbers", number: "2"),
        Lesson(title: "Kitchen", number: "3"),
        Lesson(title: "Ingredients", number: "4"),
        Lesson(title: "Advanced", number: "5"),
        Lesson(title: "Advanced", number: "6"),
        Lesson(title: "Advanced", number: "7"),
        Lesson(title: "Advanced", number: "8"),
        Lesson(title: "Advanced", number: "9"),
        Lesson(title: "Advanced", number: "10"),
    ]
}

