//
//  ScoreUIView.swift
//  QuizTP
//
//  Created by OUDJAMA Moussa (Canal Plus) on 11/02/2021.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(animationView: self)
    }
    var name: String!
    var animationView = AnimationView()
    class Coordinator: NSObject {
        var parent: LottieView
        init( animationView: LottieView) {
            self.parent = animationView
            super.init()
        }
    }
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        
        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    func updateUIView( _ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play()
        animationView.animationSpeed = 0.4
        animationView.loopMode = .loop
    }
}




struct ScoreUIView: View {
    @State var score:Int?
    
    var body: some View {
        VStack{
            Text("Score")
                .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .bottom)
                .font(.system(size: 50))
                .foregroundColor(.white)
            Text("\(score ?? 0)")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3, alignment: .center)
                .font(.system(size: 100))
                .foregroundColor(.white)
            LottieView(name: "clap")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3, alignment: .top)
            Button(action: {
               print("go to homeview")
                //CHERCHER COMMENT NAVIGUER
                // Solution Navigation Link -> X
                // Solution HostedView -> X
            }, label: {
                Text("OUT")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .background(Color.init(red: 1, green: 1, blue: 1, opacity: 0.5))
            })
        }.background(Color.red.edgesIgnoringSafeArea(.all)).navigationBarHidden(true)
    }
}

struct ScoreUIView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreUIView()
    }
}
