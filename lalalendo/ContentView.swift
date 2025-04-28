import SwiftUI

class GlobalSettings: ObservableObject {
    @Published var currentPage = 0
    @Published var next = 0
    @Published var path: [Int] = []
}

struct ContentView: View {
    @EnvironmentObject var settings: GlobalSettings
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Fundo como se fosse uma mesa
                Image("fundo livro")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                ViewController(pages: [
                    makeBookCover(text: "capa", imageName: "macaco"),
                    makeSimplePage(text: "aaaaaaaaaaaaaaaaaaadsadfzfdghbkdfjioejifnrnfjsdnkjofpkdnfjosnjfjsndjfjopnsjkdjofnjskjofnjskjfdnjsdkfEm um belo dia, você decide caminhar por uma estrada. Mas se depara com dois caminhos.", defaultImage: "macaco2", rightChoice: 3, leftChoice: 2, question: "oi", rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala", mainRightImage: "macaco", mainLeftImage: "lala"),
                    makeSimplePage(text: "nó 2", defaultImage: "lala", rightChoice: 4, leftChoice: 5, question: "oi",rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"),
                    makeSimplePage(text: "nó 3", defaultImage: "macaco", rightChoice: 6, leftChoice: 4, question: "oi", rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"),
                    makeSimplePage(text: "nó 4", defaultImage: "macaco", rightChoice: 8, leftChoice: 7, question: "oi", rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala", mainRightImage: "macaco", mainLeftImage: "macaco"),
                    makeSimplePage(text: "nó 5", defaultImage: "macaco", rightChoice: 10, leftChoice: 9, question: "oi", rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"),
                    makeSimplePage(text: "nó 6", defaultImage: "coup", rightChoice: 8, leftChoice: 7, question: "oi", rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"),
                    makeSimplePage(text: "nó 7", defaultImage: "coup", rightChoice: 12, leftChoice: 11, question: "oi", rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"),
                    makeSimplePage(text: "nó 8", defaultImage: "coup", rightChoice: 12, leftChoice: 12, question: "oi", rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",   mainRightImage: "macaco", mainLeftImage: "macaco"),
                    makeSimplePage(text: "nó 9", defaultImage: "coup", rightChoice: 13, leftChoice: 13, question: "oi", rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"), //final 1
                    makeSimplePage(text: "nó 10", defaultImage: "coup", rightChoice: 13, leftChoice: 13, question: "oi", rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"), //final 2
                    makeSimplePage(text: "nó 11", defaultImage: "coup", rightChoice: 13, leftChoice: 13, question: "oi", rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",      mainRightImage: "macaco", mainLeftImage: "macaco"), //final 3
                    makeSimplePage(text: "nó 12", defaultImage: "coup", rightChoice: 13, leftChoice: 13, question: "oi", rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala", mainRightImage: "macaco", mainLeftImage: "macaco"), //final 4
                    makeFinalPage(text: "LALALALALALLALALALALA", imageName: "macaco2", leftChoice: 14),
                    makeBookBackCover(text: "CAPA FECHADA", imageName: "macaco2")
                ])
                    .frame(
                        width: geometry.size.width * 0.85,
                        height: geometry.size.height * 0.75
                    )
                    .cornerRadius(16)
                    .shadow(radius: 10)
                // Centraliza o "livro" no centro da tela
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }.onAppear {
                settings.path.append(0)
            }
        }
    }
}
