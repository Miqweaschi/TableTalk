import SwiftUI

struct SimulationMenuListView: View {
    @ObservedObject var model: Model
    
    var body: some View {
        
        VStack(spacing: 0) {
            // Header coerente con il tuo stile
            Text("Roleplay Scenarios")
                .font(Font.largeTitle)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
                .padding(.top, 50)
                .background(Color(red: 182/255, green: 23/255, blue: 45/255))
            
            
            NavigationStack {
                List {
                    ForEach(model.simulations) { scenario in
                        NavigationLink(destination: SimulationView(scenario: scenario)) {
                            HStack {
                                Image(systemName: "bubble.left.and.bubble.right.fill")
                                    .foregroundColor(.red)
                                Text(scenario.title)
                                    .font(.headline)
                            }
                            .padding(.vertical, 10)
                        }
                    }
                }
                .scrollContentBackground(.hidden) // nasconde lo sfondo standard della List
                .background(Color(red: 255/255, green: 247/255, blue: 238/255)) // applica il tuo colore
                //.navigationTitle("Roleplay Scenarios")
            }
            .background(Color(red: 255/255, green: 247/255, blue: 238/255)) // opzionale, per la safe area
            
            
        }
    }
    
}
