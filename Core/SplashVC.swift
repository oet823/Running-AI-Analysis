//MARK: - 앱 클릭하면 보이는 첫 번쨰 화면

import UIKit

final class SplashVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.goNext()
        }
    }
    
    private func goNext() {
        
        let nextVC = RootTabBarController()
        
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate,
            let window = sceneDelegate.window
        else  { return }
        
        window.rootViewController = nextVC
        window.makeKeyAndVisible()
    }
}
