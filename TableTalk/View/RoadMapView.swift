import Foundation
import SwiftUI
import UIKit

struct RoadMapView: View {
    let lesson: Lesson
    
    var body: some View {
        NavigationStack {
            
            // Iteri sugli argomenti della lezione passata in LessonView().
            // Per ogni argomento crei un bottone che ti porta alla pagina dedicata
            // al singolo argomento
            // Esempio:
            // Lezione1: Lesson -> contiene argomentiL1 -> contiene ad esempio 5 argomenti
            // per ogni argomento creiamo un bottone che ci porta alla pagina ArgomentoView()
            // relativo allo specifico argomento
            ForEach(lesson.argomenti.keys.sorted(), id: \.self) { key in
                let valueAtKey = lesson.argomenti[key]
                NavigationLink {
                    // Passiamo il contenuto dell'argomento
                    ArgomentoView(arg: valueAtKey!)
                }
                label: {
                    HStack {
                        Text("\(key)")
                    }
                }
                .padding()
                .background(Color(.systemGray5))
                .clipShape(.circle)
            }
        }
    }
}
