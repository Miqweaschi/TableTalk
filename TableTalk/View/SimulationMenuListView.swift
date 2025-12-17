import SwiftUI

struct SimulationMenuListView: View {
    @ObservedObject var model: Model
    
    var body: some View {
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
            .navigationTitle("Roleplay Scenarios")
        }
    }
}
