import UIKit
import SwiftUI

//tudo relacionado a UIKit nesse arquivo

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

func makeBookCover(text: String, imageName: String) -> UIViewController{
    let cover =  CoverView(text: text, imageName: imageName)
    let hostingController = UIHostingController(rootView: cover)
    hostingController.view.backgroundColor = .clear
    return hostingController
}

func makeBookBackCover(text: String, imageName: String) -> UIViewController{
    let backCover =  BackCoverView(text: text, imageName: imageName)
    let hostingController = UIHostingController(rootView: backCover)
    hostingController.view.backgroundColor = .clear
    return hostingController
}

func makeFinalPage(text: String, imageName: String, leftChoice: Int) -> UIViewController{
    let finalPage =  FinalPageView(text: text, defaultImage: imageName, leftChoice:leftChoice)
    let hostingController = UIHostingController(rootView: finalPage)
    hostingController.view.backgroundColor = .orange
    return hostingController
}
