//
//  AuthVC.swift
//  RCA(Programmatic UI)
//
//  Created by 오은택 on 3/8/26.
//
import UIKit

final class AuthVC: UIViewController {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "RFCAppIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    private func setUpUI() {
        
        view.addSubview(backgroundImageView)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            loginButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -5),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    @objc private func didTapLogin() {
        let nextVC = RootTabBarController()
        
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate,
            let window = sceneDelegate.window
        else { return }
        
        window.rootViewController = nextVC
        window.makeKeyAndVisible()
    }
}
