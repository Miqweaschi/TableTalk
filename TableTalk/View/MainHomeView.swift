//
//  MainHomeView.swift
//  TableTalk
//
//  Created by AFP PAR 21 on 05/12/25.
//

import Foundation
import SwiftUI

struct MainHomeView: View {
    var body: some View {
            VStack {
               Text("Welcome Back, Christian")
                    .font(Font.largeTitle)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom,20)
                    .padding(.top,50)
                    .background(Color(red: 0.70, green: 0.0, blue: 0.1))
                    Spacer()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomeView()
    }
}

