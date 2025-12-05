//
//  ContentView.swift
//  TableTalk
//
//  Created by AFP PAR 21 on 05/12/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model =  Model()
    @State var TabSelection = 0
    
    var body: some View {
        TabView {
            // ActivityView()
            MainHomeView()
                .tabItem {
                Label("Activity", systemImage: "calendar")
            }
            
            //LessonsView()
            MainHomeView()
                .tabItem {
                Label("Lessons", systemImage: "book.closed")
            }
            
            //SimulationView()
            MainHomeView()
                .tabItem {
                Label("Simulation", systemImage: "play.fill")
            }
            
            //SettingsView()
            MainHomeView()
                .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
        
    }
}
    #Preview {
        ContentView()
    }

