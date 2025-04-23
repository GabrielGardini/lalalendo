import SwiftUI
import UIKit
import AVFoundation

class GlobalSettings: ObservableObject {
    @Published var currentPage = 0
    @Published var next = 0
    @Published var path: [Int] = []
}

struct ViewController: UIViewControllerRepresentable {
    @EnvironmentObject var settings: GlobalSettings
    var pages: [UIViewController]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, settings: settings)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageVC = UIPageViewController(
            transitionStyle: .pageCurl,
            navigationOrientation: .horizontal,
            options: nil
        )
        pageVC.dataSource = context.coordinator
        pageVC.setViewControllers([pages[0]], direction: .forward, animated: true)
        return pageVC
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {}
    
    class Coordinator: NSObject, UIPageViewControllerDataSource {
        var parent: ViewController
        var settings: GlobalSettings
        
        init(_ parent: ViewController, settings: GlobalSettings) {
            self.parent = parent
            self.settings = settings
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            //aqui temos que ir para o no anterior da historia
            guard let index = parent.pages.firstIndex(of: viewController), index > 0 else {
                return nil
            }
            //se nao tiver na primeira pagina
            settings.path.removeLast()
            settings.currentPage = settings.path.last ?? 0
            settings.next = settings.currentPage
            return parent.pages[settings.currentPage]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            //aqui temos que ir para o no seguinte da historia baseado na escolha da crianca
            guard let index = parent.pages.firstIndex(of: viewController), index + 1 < parent.pages.count else {
                return nil
            }
            settings.currentPage = settings.next
            return parent.pages[settings.currentPage]
        }
    }
}

struct SimplePageView: View {
    @EnvironmentObject var settings: GlobalSettings
    var text: String
    var defaultImage: String //essa vai ser a imagem default, a das escolhas muda no botao
    var rightChoice: Int
    var leftChoice: Int
    
    
    var rightButtonImage: String
    var rightButtonText: String
    var leftButtonImage: String
    var leftButtonText: String
    var mainRightImage: String
    var mainLeftImage: String
    
    @State private var imageName: String = ""
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
        utterance.rate = 0.5 // velocidade da fala (0.0 a 1.0)
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack(alignment: .center, spacing: 20) {
                    Text(text)
                        .font(.title)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    
                    Button(action: {
                        speak(text + "pergunta" + "botao1" + "botao2")
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 217/255, green: 217/255, blue: 217/255))                        .frame(width: 50, height: 50)
                            
                            Image(systemName: "speaker.wave.2.fill") // ou "mic.fill", "waveform", etc
                                .font(.title2)
                                .foregroundColor(Color(red: 88/255, green: 86/255, blue: 214/255))
                        }
                    }
                    
                    
                    Text("pergunta")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    HStack (spacing:20){
                        OptionButton(title: "Opção 1", image: leftButtonImage, onSelect: {
                            imageName = mainLeftImage
                            settings.next = leftChoice
                        })
                        
                        
                        OptionButton(title: "Opção 1", image: rightButtonImage, onSelect: {
                            imageName = mainRightImage
                            settings.next = rightChoice
                        })
                    }
                }
                    .padding()
                    .frame(width: geometry.size.width * 0.5, alignment: .center)
                    .background(.white)
                    
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * 0.5 )
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.white)
                .cornerRadius(16)
            }.onAppear{
                imageName = defaultImage
                settings.next = leftChoice // caso nao clique em nenhum a default eh toda pra esquerda
                settings.path.append(settings.currentPage)
            }
        }
    }

    
    
    
    struct OptionButton: View {
        @EnvironmentObject var settings: GlobalSettings
        var title: String
        var image: String
        var onSelect: () -> Void
        
        struct RoundedCornerShape: Shape {
            var radius: CGFloat
            var corners: UIRectCorner
            
            func path(in rect: CGRect) -> Path {
                let path = UIBezierPath(
                    roundedRect: rect,
                    byRoundingCorners: corners,
                    cornerRadii: CGSize(width: radius, height: radius)
                )
                return Path(path.cgPath)
            }
        }
        
        var body: some View {
            Button(action: {
                onSelect()
            }) {
                VStack(alignment: .center, spacing:0) {
                    Image(image)
                        .resizable()
                        .frame(width: 130, height: 130)
                        .background(Color.black.opacity(0.2))
                        .clipShape(
                            RoundedCornerShape(radius: 8, corners: [.topLeft, .topRight])
                        )
                    ZStack {
                        Rectangle()
                            .fill(Color(red: 220/255, green: 231/255, blue: 249/255))                        .frame(width: 130, height: 30)
                        
                        Text("texto do botao")
                            .foregroundColor(.black)
                    }.clipShape(
                        RoundedCornerShape(radius: 8, corners: [.bottomLeft, .bottomRight])
                    )
                }
            }
        }
    }

    struct CoverView: View {
        @EnvironmentObject var settings: GlobalSettings
        var text: String
        var imageName: String
        
        var body: some View {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height)
                        .background(Color.teal)
                        .clipped()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.brown.opacity(0.2))
                .cornerRadius(16)
            }.onAppear{
                settings.next = 1
            }
        }
    }
    
    
    func makeSimplePage(text: String, defaultImage: String, rightChoice: Int, leftChoice: Int, rightButtonImage: String, rightButtonText: String, leftButtonImage: String, leftButtonText: String, mainRightImage: String, mainLeftImage: String) -> UIViewController {
        let page = SimplePageView(text: text,
                                  defaultImage: defaultImage,
                                  rightChoice: rightChoice,
                                  leftChoice: leftChoice,
                                  rightButtonImage: rightButtonImage,
                                  rightButtonText: rightButtonText,
                                  leftButtonImage: leftButtonImage,
                                  leftButtonText: leftButtonText,
                                  mainRightImage: mainRightImage,
                                  mainLeftImage: mainLeftImage)
        return UIHostingController(rootView: page)
    }
    
    //arrumar isso
    func makeBookCover(text: String, imageName: String) -> UIViewController{
        let cover =  CoverView(text: text, imageName: imageName)
        return UIHostingController(rootView: cover)
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
                        makeSimplePage(text: "nó 1", defaultImage: "macaco2", rightChoice: 3, leftChoice: 2, rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala", mainRightImage: "macaco", mainLeftImage: "lala"),
                        makeSimplePage(text: "nó 2", defaultImage: "lala", rightChoice: 4, leftChoice: 5,   rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"),
                        makeSimplePage(text: "nó 3", defaultImage: "macaco", rightChoice: 6, leftChoice: 4, rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"),
                        makeSimplePage(text: "nó 4", defaultImage: "macaco", rightChoice: 8, leftChoice: 7, rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala", mainRightImage: "macaco", mainLeftImage: "macaco"),
                        makeSimplePage(text: "nó 5", defaultImage: "macaco", rightChoice: 10, leftChoice: 9, rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"),
                        makeSimplePage(text: "nó 6", defaultImage: "coup", rightChoice: 8, leftChoice: 7, rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"),
                        makeSimplePage(text: "nó 7", defaultImage: "coup", rightChoice: 12, leftChoice: 11, rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"),
                        makeSimplePage(text: "nó 8", defaultImage: "coup", rightChoice: 12, leftChoice: 12, rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",   mainRightImage: "macaco", mainLeftImage: "macaco"),
                        makeSimplePage(text: "nó 9", defaultImage: "coup", rightChoice: 13, leftChoice: 13, rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"), //final 1
                        makeSimplePage(text: "nó 10", defaultImage: "coup", rightChoice: 13, leftChoice: 13, rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",  mainRightImage: "macaco", mainLeftImage: "macaco"), //final 2
                        makeSimplePage(text: "nó 11", defaultImage: "coup", rightChoice: 13, leftChoice: 13, rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala",      mainRightImage: "macaco", mainLeftImage: "macaco"), //final 3
                        makeSimplePage(text: "nó 12", defaultImage: "coup", rightChoice: 13, leftChoice: 13, rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala", mainRightImage: "macaco", mainLeftImage: "macaco"), //final 4
                        makeSimplePage(text: "nó final 13", defaultImage: "coup", rightChoice: 13, leftChoice: 13, rightButtonImage: "macaco", rightButtonText: "macaco", leftButtonImage: "lala", leftButtonText: "lala", mainRightImage: "macaco", mainLeftImage: "macaco"), //aqui vai ser um objeto diferente que eh a pagina fechada, n tem escolhas.
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
