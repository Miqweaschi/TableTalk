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
class Model:ObservableObject {
    
    
    @Published var tabBarChanged = false
    @Published var tabViewSelectedIndex = Int.max{
        didSet {
            tabBarChanged = true
        }
    }
}
