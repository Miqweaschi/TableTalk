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

    var body: some View {
        VStack {
            Text("Lessons")
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
                .padding(.top, 30)
            
            // usiamo scroll view invece di list perché visivamente ha un impatto migliore, adatta meglio le cose allo schermo

                
                ScrollView {
                    VStack {
                        HStack {
                            Text("1")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.white)
                                .background(Color(r:182,g:23,b:45,opacity:100))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            
                            Text("Basics")
                                .foregroundColor(.black)
                            
                            // questa funzione sarebbe meglio utilizzarla nella roadmap, così che quando clicchiamo su un "livello" della roadmap ci aprirà la teoria inerente a quella unità allo stesso modo di questa funzione.
                            
                            // per cui qui facciamo che quando si clicca su un capitolo ci porta alla "RoadMapNomeView", in cui mettiamo la roadmap e quando clicchiamo su una casella fa quanto citato sopra
                            
                                /*.sheet(isPresented: $isPresented){
                                    NavigationView {TextField("nome ciao", text: $ciao)}}*/
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack {
                            Text("2")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.white)
                                .background(Color(r:182,g:23,b:45,opacity:100))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text("Advanced")
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack {
                            Text("3")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.white)
                                .background(Color(r:182,g:23,b:45,opacity:100))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text("Advanced")
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack {
                            Text("4")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.white)
                                .background(Color(r:182,g:23,b:45,opacity:100))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text("Advanced")
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack {
                            Text("5")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.white)
                                .background(Color(r:182,g:23,b:45,opacity:100))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text("Advanced")
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack {
                            Text("6")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.white)
                                .background(Color(r:182,g:23,b:45,opacity:100))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text("Advanced")
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack {
                            Text("7")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.white)
                                .background(Color(r:182,g:23,b:45,opacity:100))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text("Advanced")
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack {
                            Text("8")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.white)
                                .background(Color(r:182,g:23,b:45,opacity:100))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text("Advanced")
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack {
                            Text("9")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.white)
                                .background(Color(r:182,g:23,b:45,opacity:100))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text("Advanced")
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack {
                            Text("10")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundColor(.white)
                                .background(Color(r:182,g:23,b:45,opacity:100))
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
                .background(Color(r: 255,g: 247,b: 238,opacity: 100))
            }
        }
        }
    


#Preview {
    LessonsView()
}
