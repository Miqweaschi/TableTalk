//
//  ContentView.swift
//  TableTalk
//
//  Created by AFP PAR 21 on 05/12/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        //TabView ci permette di creare una barra di navigazione.
        TabView {
            // ActivityView()
            MainHomeView()
                .tabItem {
                Label("Activity", systemImage: "calendar")
            }
            
            LessonsView()
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
        .tint((Color(r:182,g:23,b:45,opacity:100)))
        
    }
}


    #Preview {
        ContentView()
    }

