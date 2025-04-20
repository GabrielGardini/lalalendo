import SwiftUI
import UIKit

struct ViewController: UIViewControllerRepresentable {
    var pages: [UIViewController]

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
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

        init(_ parent: ViewController) {
            self.parent = parent
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            //aqui temos que ir para o no anterior da historia 
            guard let index = parent.pages.firstIndex(of: viewController), index > 0 else {
                return nil
            }
            //se nao tiver na primeira pagina
            path.removeLast()
            currentPage = path.last
            //return parent.pages[before]
            return parent.pages[currentPage]  
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            //aqui temos que ir para o no seguinte da historia baseado na escolha da crianca
            guard let index = parent.pages.firstIndex(of: viewController), index + 1 < parent.pages.count else {
                return nil
            }
            path.append(currentPage)
            currentPage = next
            return parent.pages[currentPage]
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
            HStack(spacing: 0) {
                // 📕 Esquerda: Texto + Botões
                VStack(alignment: .leading, spacing: 20) {
                    Text(text)
                        .font(.title)
                        .foregroundColor(.white)

                    VStack(spacing: 10) {
                        HStack(spacing: 10) {
                            OptionButton(title: "Opção 1", leftChoice)
                            OptionButton(title: "Opção 2", rightChoice)
                        }
                        HStack(spacing: 10) {
                            OptionButton(title: "Opção 3")
                            OptionButton(title: "Opção 4")
                        }
                    }
                }
                .padding()
                .frame(width: geometry.size.width * 0.5, height: geometry.size.height)
                .background(Color.teal)

                // 🖼️ Direita: Imagem
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height)
                    .background(Color.teal)
                    .clipped()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .cornerRadius(16)
        }
    }
}


struct OptionButton: View {
    var title: String
    var choice: Int

    var body: some View {
        Button(action: {
            next = choice
        }) {
            Text(title)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

func makeSimplePage(text: String, imageName: String) -> UIViewController {
    let page = SimplePageView(text: text, imageName: imageName)
    return UIHostingController(rootView: page)
}

struct ContentView: View {
    @State private var currentPage = 0
    @State private var next = 0
    @State private var path: [Int]
    path.append(0) 

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Fundo como se fosse uma mesa
                Color.brown.opacity(0.2)
                    .ignoresSafeArea()

                // Container do "livro"
                ViewController(pages: [
                    makeSimplePage(text: "Você acorda numa floresta encantada. De repente, enxerga um misterioso animal. Quando chega mais perto, você descobre que era um:", imageName: "macaco"),
                    makeSimplePage(text: "Ele adorava aventuras!", imageName: "coup"),
                    makeSimplePage(text: "Fim da história!", imageName: "coup")
                ])
                .frame(
                    width: geometry.size.width * 0.85,
                    height: geometry.size.height * 0.75
                )
                .cornerRadius(16)
                .shadow(radius: 10)
                // Centraliza o "livro" no centro da tela
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
}







