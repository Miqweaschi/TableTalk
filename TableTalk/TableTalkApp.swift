//
//  TableTalkApp.swift
//  TableTalk
//
//  Created by AFP PAR 21 on 05/12/25.
//

import SwiftUI

@main
struct TableTalkApp: App {
    @StateObject private var model = Model()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}


#Preview {
    ContentView()
}
