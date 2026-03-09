//MARK: - 앱 클릭하면 보이는 첫 번쨰 화면

import UIKit

final class SplashVC: UIViewController {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "RFCAppIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.goNext()
        }
    }
    
    private func setUpUI() {
        view.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func goNext() {
        
        let nextVC = AuthVC()
        
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate,
            let window = sceneDelegate.window
        else  { return }
        
        window.rootViewController = nextVC
        window.makeKeyAndVisible()
    }
}
