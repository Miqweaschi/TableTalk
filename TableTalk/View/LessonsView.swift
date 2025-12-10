//
//  LessonsView.swift
//  TableTalk
//
//  Created by AFP PAR 35 on 09/12/25.
//

import SwiftUI

struct LessonsView: View {
    @State private var i: Int = 0
    @State var ciao: String = "Ciao"
    @State var isPresented = true
    private let totalLessons = 30
    
    var body: some View {
        VStack {
            Text("Lessons")
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
                .padding(.top, 30)
            
            ScrollView {
                VStack {
                    ForEach(1...totalLessons, id: \.self) { i in
                        HStack {
                            Text("\(i)")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .background(
                                    Color(red: 182/255, green: 23/255, blue: 45/255)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text("Advanced")
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .background(Color(red: 255/255, green: 247/255, blue: 238/255))
        }
    }
}

#Preview {
    LessonsView()
}
