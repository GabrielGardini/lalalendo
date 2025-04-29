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
                    makeBookCover(text: "As aventuras de Lala", imageName: "capa livro frente"),
                    makeSimplePage(text: "Em um belo dia, você decide caminhar por uma estrada. Mas se depara com dois caminhos.", defaultImage: "id1 - default", rightChoice: 3, leftChoice: 2, question: "Qual você escolhe?", rightButtonImage: "id1 opcao2", rightButtonText: "Floresta", leftButtonImage: "id1 opcao1", leftButtonText: "Cidade", mainRightImage: "id1 opcao2", mainLeftImage: "id1 opcao1"),
                    makeSimplePage(text: "Ao chegar na cidade, percebe que ela está toda sem cores! Tudo é cinza, triste e sem graça. As casas, o céu, e até mesmo o parquinho.", defaultImage: "id2 default", rightChoice: 5, leftChoice: 4, question: "Qual parte você quer explorar?", rightButtonImage: "id2 opcao2", rightButtonText: "Parquinho", leftButtonImage: "id2 opcao1", leftButtonText: "Casas",  mainRightImage: "id2 opcao2", mainLeftImage: "id2 opcao1"),
                    makeSimplePage(text: "Ao chegar na floresta, encontra dois animais: um cachorrinho que parece estar perdido e um mico leão dourado deitado no galho de uma árvore.", defaultImage: "id3 default", rightChoice: 7, leftChoice: 6, question: "Com qual animal você quer falar?", rightButtonImage: "id3 opcao2", rightButtonText: "Mico", leftButtonImage: "id3 opcao1", leftButtonText: "Cão",  mainRightImage: "id3 opcao2", mainLeftImage: "id3 opcao1"),
                    makeSimplePage(text: "Você anda em direção a uma casa, e ao entrar nela, você encontra dois presentes!", defaultImage: "id4 default", rightChoice: 9, leftChoice: 8, question: "Qual você escolhe?", rightButtonImage: "id4 opcao2", rightButtonText: "Quadrado", leftButtonImage: "id4 opcao1", leftButtonText: "Redondo", mainRightImage: "id4 opcao2", mainLeftImage: "id4 opcao1"),
                    makeSimplePage(text: "Chegando no parquinho, você encontra seu amigo com seu cachorrinho Lulu que foge para a floresta de repente!", defaultImage: "id5 default", rightChoice: 11, leftChoice: 10, question: "Você vai atrás de Lulu ou ficar com seu amigo?", rightButtonImage: "id5 opcao2", rightButtonText: "Cão", leftButtonImage: "id5 opcao1", leftButtonText: "Amigo",  mainRightImage: "id5 opcao2", mainLeftImage: "id5 opcao1"),
                    makeSimplePage(text: "Você ia falar com o cãozinho, mas ele correu. Você o segue até o parquinho e encontra seu amigo, que diz que o cachorro é dele, mas está triste demais para procurá-lo.", defaultImage: "id6 default", rightChoice: 13, leftChoice: 12, question: "Ficar com seu amigo ou procurar o cãozinho?", rightButtonImage: "id6 opcao2", rightButtonText: "Cão", leftButtonImage: "id6 opcao1", leftButtonText: "Amigo",  mainRightImage: "id6 opcao2", mainLeftImage: "id6 opcao1"),
                    makeSimplePage(text: "O mico te mostra a floresta mágica. Tudo é muito bonito, tem flores e animais encantados! Você quer explorar tudo, mas vê seu amigo ao longe, bem triste porque seu cãozinho fugiu.", defaultImage: "id7 default", rightChoice: 15, leftChoice: 14, question: "Ficar com seu amigo ou explorar a floresta?", rightButtonImage: "id7 opcao2", rightButtonText: "Floresta", leftButtonImage: "id7 opcao1", leftButtonText: "Amigo",  mainRightImage: "id7 opcao2", mainLeftImage: "id7 opcao1"),
                    makeFinalPage(text: "De dentro da caixa redonda, pula um cachorrinho! Mas não um cachorro comum, ele é todo colorido! Juntos, vocês colorem a cidade com as cores do arco-íris. Cada traço era um pedacinho de alegria, e quem passava ficava mais feliz. Desde então, ninguém esqueceu: um pouco de cor pode encher o mundo de felicidade!", imageName: "id8 default", leftChoice: 18),
                    makeFinalPage(text: "Você abre a caixa e encontra vários lápis de cor! Com brilho nos olhos, decide dar fim à cidade cinza, pintando o céu de azul e os muros de amarelo-sol. Cada traço era um pedacinho de alegria, e quem passava ficava mais feliz. Desde então, ninguém esqueceu: um pouco de cor pode encher o mundo de felicidade!", imageName: "id9 default", leftChoice: 18),
                    makeFinalPage(text: "Você vai até a casa do seu amigo e encontra o cachorrinho, agora todo colorido! Enquanto estava perdido, ele encontrou uma fruta mágica e, ao comer, se transformou em um arco-íris de pelos. Juntos, com a ajuda do cachorrinho, vocês pintaram a cidade, espalhando alegria e cores por todo lado.", imageName: "id10 default", leftChoice: 18),
                    makeFinalPage(text: "Você descobre que a floresta é encantada e tudo lá é colorido, você encontra o cachorrinho lá, todo feliz e cheio de cores! Juntos, decidem levar a magia para a cidade, espalhando tinta e alegria por onde passam. Cada traço de cor transforma a cidade, deixando tudo mais bonito e brilhante.", imageName: "id11 default", leftChoice: 18),
                    makeSimplePage(text: "Você vê que seu amigo está triste e decide ficar com ele. Você pode continuar no parquinho ou levá-lo para casa.", defaultImage: "id12 default", rightChoice: 16, leftChoice: 16, question: "O que você faz?", rightButtonImage: "id12 opcao2", rightButtonText: "Casa", leftButtonImage: "id12 opcao1", leftButtonText: "Parquinho", mainRightImage: "id12 opcao2", mainLeftImage: "id12 opcao1"),
                    makeSimplePage(text: "O cachorro correu para a floresta e você decidiu segui-lo. Lá, encontra uma árvore enorme que te dá uma vista de toda a floresta e também algumas pegadas.", defaultImage: "id13 default", rightChoice: 17, leftChoice: 17, question: "Qual delas você prefere explorar?", rightButtonImage: "id13 opcao2", rightButtonText: "Pegadas", leftButtonImage: "id13 opcao1", leftButtonText: "Árvore", mainRightImage: "id13 opcao2", mainLeftImage: "id13 opcao1"),
                    makeSimplePage(text: "Você encontra seu amigo, bem triste, com saudades de seu cachorrinho. Você pode levá-lo para casa ou esperar juntos na floresta até ele se sentir melhor?", defaultImage: "id14 default", rightChoice: 16, leftChoice: 16, question: "O que você vai fazer?", rightButtonImage: "id14 opcao2", rightButtonText: "Floresta", leftButtonImage: "id14 opcao1", leftButtonText: "Casa", mainRightImage: "id14 opcao2", mainLeftImage: "id14 opcao1"),
                    makeSimplePage(text: "Na floresta mágica, você encontra vários animais encantados brincando felizes. Você pode se juntar a eles ou continuar procurando o cachorrinho?", defaultImage: "id15 default", rightChoice: 17, leftChoice: 17, question: "O que você prefere?", rightButtonImage: "id15 opcao2", rightButtonText: "Procurar cachorro", leftButtonImage: "id15 opcao1", leftButtonText: "Brincar", mainRightImage: "id15 opcao2", mainLeftImage: "id15 opcao1"),
                    makeFinalPage(text: " Enquanto você fazia companhia pro seu amigo, o cachorrinho voltou correndo e pulou nos braços dele! Eles se reencontraram cheios de alegria, e todos brincaram juntos na floresta encantada. Às vezes, esperar com carinho é tudo o que um amigo precisa.", imageName: "id16 default", leftChoice: 18),
                    makeFinalPage(text: "Você encontra o cachorrinho e se encanta com suas cores, ele parecia um arco-íris, brincando feliz com outros bichinhos na floresta mágica. Então, você entende que aquele era o verdadeiro lar dele, e que, às vezes, amar é deixar quem a gente gosta ser feliz onde realmente pertence.", imageName: "id17 default", leftChoice: 18),
                    makeBookBackCover(text: "CAPA FECHADA", imageName: "backCover")
                ])
                    .frame(
                        width: geometry.size.width * 0.85,
                        height: geometry.size.height * 0.85
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
