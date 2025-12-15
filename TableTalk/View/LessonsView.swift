//
//  LessonsView.swift
//  TableTalk
//
//  Created by AFP PAR 35 on 09/12/25.
//

import SwiftUI

struct LessonsView: View {
    @EnvironmentObject var model:Model
    
    var body: some View {
        let lessonList = model.lessonsList
        NavigationStack{
            VStack {
                Text("Lessons")
                    .font(Font.largeTitle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom,20)
                    .padding(.top,50)
                    .background(Color(r:182,g:23,b:45,opacity:100))
                
                Spacer()
                
                ScrollView {
                    VStack {
                        
                        // Iteriamo sulla lista delle lezioni presenti.
                        // Ogni lezione contiene: numero, titolo e lista argomenti relativi ad essa.
                        // La lista degli argomenti relativa ad una lezione la passiamo a RoadMapView
                        // vedi RoadMapView() per spiegazione
                        
                        ForEach(lessonList, id: \.self) { lesson in
                            NavigationLink{
                                
                                // Passiamo la lezione i-esima alla RMW()
                                RoadMapView(lesson: lesson, lessonIndex: 1, model: model)
                            } label: {
                                HStack {
                                    Text(lesson.number)
                                        .font(.title)
                                        .frame(width: 40, height: 50)
                                        .foregroundColor(.white)
                                        .background(
                                            Color(red: 182/255, green: 23/255, blue: 45/255)
                                        )
                                    
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    
                                    Text(lesson.title.uppercased())
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding()
                                .background(Color(.systemGray5))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                }
                .background(Color(r: 255,g: 247,b: 238,opacity: 100))
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Model())
}
