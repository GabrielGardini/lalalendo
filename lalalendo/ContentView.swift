import SwiftUI
import UIKit

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
            settings.next = settings.currentPage
            settings.currentPage = settings.path.last ?? 0
            return parent.pages[settings.currentPage]
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            //aqui temos que ir para o no seguinte da historia baseado na escolha da crianca
            guard let index = parent.pages.firstIndex(of: viewController), index + 1 < parent.pages.count else {
                return nil
            }
            settings.path.append(settings.currentPage)
            settings.currentPage = settings.next
            print(settings.currentPage)
            return parent.pages[settings.currentPage]
        }
    }
}

struct SimplePageView: View {
    var text: String
    var imageName: String
    var rightChoice: Int
    var leftChoice: Int

    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack(alignment: .center, spacing: 20) {
                    Text(text)
                        .font(.title)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        
                    
                    Text("pergunta")
                        .font(.title)
                        .foregroundColor(.black)

                    VStack(spacing: 10) {
                        HStack(spacing: 10) {
                           
                            OptionButton(title: "Opção 1", image:"macaco", choice: leftChoice)
                            
                            Spacer()
                           
                            OptionButton(title: "Opção 1", image:"macaco2", choice: rightChoice)
                        }
                        
                    }
                }
                .padding()
                .frame(width: geometry.size.width * 0.5, alignment: .center)
                .background(.white)

                // 🖼️ Direita: Imagem
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 0.5 )
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.black)
            .cornerRadius(16)
        }
    }
}

struct OptionButton: View {
    @EnvironmentObject var settings: GlobalSettings
    var title: String
    var image: String
    var choice: Int

    var body: some View {
        GeometryReader { geometry in
        Button(action: {
            settings.next = choice
        }) {
            VStack(alignment: .center, spacing:0){
                Image(image).resizable()
                    .frame(maxWidth: geometry.size.width * 0.5, maxHeight: geometry.size.width * 0.5)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(8)
                Text("texto do botao")
                    .background(Color.white)
            }
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


func makeSimplePage(text: String, imageName: String, rightChoice: Int, leftChoice: Int) -> UIViewController {
    let page = SimplePageView(text: text, imageName: imageName, rightChoice: rightChoice, leftChoice: leftChoice)
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
                Color.brown.opacity(0.2)
                    .ignoresSafeArea()

                ViewController(pages: [
                    makeBookCover(text: "capa", imageName: "macaco"),
                    makeSimplePage(text: "Você acorda numa floresta encantada. De repente, enxerga um misterioso animal. Quando chega mais perto, você descobre que era um:", imageName: "macaco", rightChoice: 3, leftChoice: 2),
                    makeSimplePage(text: "nó 1", imageName: "macaco", rightChoice: 4, leftChoice: 5),
                    makeSimplePage(text: "nó 2", imageName: "macaco", rightChoice: 6, leftChoice: 4),
                    makeSimplePage(text: "nó 3", imageName: "macaco", rightChoice: 8, leftChoice: 7),
                    makeSimplePage(text: "nó 4", imageName: "macaco", rightChoice: 10, leftChoice: 9),
                    makeSimplePage(text: "nó 5", imageName: "coup", rightChoice: 8, leftChoice: 7),
                    makeSimplePage(text: "nó 6", imageName: "coup", rightChoice: 12, leftChoice: 11),
                    makeSimplePage(text: "nó 7", imageName: "coup", rightChoice: 12, leftChoice: 12),
                    makeSimplePage(text: "nó 8", imageName: "coup", rightChoice: 13, leftChoice: 13), //final 1
                    makeSimplePage(text: "nó 9", imageName: "coup", rightChoice: 13, leftChoice: 13), //final 2
                    makeSimplePage(text: "nó 10", imageName: "coup", rightChoice: 13, leftChoice: 13), //final 3
                    makeSimplePage(text: "nó 11", imageName: "coup", rightChoice: 13, leftChoice: 13), //final 4
                    makeSimplePage(text: "nó final 12", imageName: "coup", rightChoice: 13, leftChoice: 13), //aqui vai ser um objeto diferente que eh a pagina fechada, n tem escolhas.
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
