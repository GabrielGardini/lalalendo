import SwiftUI
import UIKit

struct PageCurlViewController: UIViewControllerRepresentable {
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
        var parent: PageCurlViewController

        init(_ parent: PageCurlViewController) {
            self.parent = parent
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = parent.pages.firstIndex(of: viewController), index > 0 else {
                return nil
            }
            return parent.pages[index - 1]
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.pages.firstIndex(of: viewController), index + 1 < parent.pages.count else {
                return nil
            }
            return parent.pages[index + 1]
        }
    }
}


struct SimplePageView: View {
    var text: String
    var imageName: String

    var body: some View {
        HStack {
            // 📕 Esquerda: Texto + Botões
            VStack(alignment: .leading, spacing: 20) {
                Text(text)
                    .font(.title)
                    .foregroundColor(.white)

                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        OptionButton(title: "Opção 1")
                        OptionButton(title: "Opção 2")
                    }
                    HStack(spacing: 10) {
                        OptionButton(title: "Opção 3")
                        OptionButton(title: "Opção 4")
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

            // 🖼️ Direita: Imagem
            Image("macaco")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .frame(width:300, height:300)
        }
        .background(Color.teal)
        .cornerRadius(16)
    }
}

struct OptionButton: View {
    var title: String

    var body: some View {
        Button(action: {
            print("Clicou em \(title)")
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
    var body: some View {
        ZStack {
            // Fundo como se fosse a mesa
            Color.brown.opacity(0.2)
                .ignoresSafeArea()

            // Container do livro
            PageCurlViewController(pages: [
                            makeSimplePage(text: "Era uma vez um macaquinho...", imageName: "macaco"),
                            makeSimplePage(text: "Ele adorava aventuras!", imageName: "coup.png"),
                            makeSimplePage(text: "Fim da história!", imageName: "coup")
                        ])
            .frame(width: 900, height: 600) // Ajuste conforme o tamanho que quiser pro "livro"
            .cornerRadius(16)
            .shadow(radius: 10)
        }
    }
}









