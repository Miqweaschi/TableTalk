import SwiftUI

struct LessonsView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header coerente con il tuo stile
                Text("Lessons")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 20)
                    .padding(.top, 50)
                    .background(Color(red: 182/255, green: 23/255, blue: 45/255))
                
                ScrollView {
                    VStack(spacing: 15) {
                        // Usiamo enumerated() per passare l'indice corretto
                        ForEach(Array(model.lessonsList.enumerated()), id: \.element.id) { index, lesson in
                            
                            NavigationLink(destination: RoadMapView(lesson: lesson, lessonIndex: index, model: model)) {
                                // IL LABEL DEVE STARE DENTRO LE GRAFFE DEL NAVIGATIONLINK
                                HStack {
                                    Text(lesson.number)
                                        .font(.title)
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.white)
                                        .background(Color(red: 182/255, green: 23/255, blue: 45/255))
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    
                                    Text(lesson.title.uppercased())
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .padding(.leading, 10)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(.systemGray5))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 20)
                }
                .background(Color(red: 255/255, green: 247/255, blue: 238/255))
            }
        }
    }
}
