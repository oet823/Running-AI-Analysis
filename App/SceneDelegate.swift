//
//  SceneDelegate.swift
//  RCA(Programmatic UI)
//
//  Created by 오은택 on 2/27/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 1. 앱이 보여질 '무대'를 가져옵니다.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 2. 그 무대에 딱 맞는 '유리창(Window)'을 하나 만듭니다.
        let window = UIWindow(windowScene: windowScene)
        
        // 3. 첫 화면으로 우리가 만든 'ViewController'를 지정합니다.
        // (이때 ViewController.swift 안에 배경색 코드가 있어야 주황색이 나옵니다.)
        window.rootViewController = SplashVC()
        
        // 4. 이 유리창을 메인으로 설정하고 불을 켭니다.
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

