import SwiftUI

struct ContentView: View {
 
    @StateObject private var model = Model()
    
    var body: some View {
        TabView {
            
            MainHomeView()
                .tabItem {
                    Label("Attività", systemImage: "calendar")
                }
            
        
            LessonsView()
                .tabItem {
                    Label("Lezioni", systemImage: "book.closed")
                }
            
           
            SimulationMenuListView(model: model)
                .tabItem {
                    Label("Simulazione", systemImage: "play.fill")
                }
        }
        
        .tint(Color(red: 182/255, green: 23/255, blue: 45/255))
    }
}

#Preview {
    ContentView()
}
