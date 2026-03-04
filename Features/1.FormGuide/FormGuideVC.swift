//
//  FormGuideVC.swift
//  RCA(Programmatic UI)
//
//  Created by 오은택 on 2/27/26.
//

import UIKit

final class FormGuideVC: UIViewController {
    
    
    
    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "person.crop.circle")
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        let config = UIImage.SymbolConfiguration(pointSize: 36, weight: .regular)
        button.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        return button
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .semibold)
        label.textColor = .label
        label.text = "Form Guide"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.text = "카테고리별로 찾아보기"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let stackView: UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        st.spacing = 14
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    private struct FormGuideCard {
        let title: String
        let imageName: String
    }
    
    private let cards: [FormGuideCard] = [
        .init(title: "상체 각도", imageName: "upperBodyAngle"),
        .init(title: "팔 스윙 각도", imageName: "armSwingAngle"),
        .init(title: "무릎 높이", imageName: "kneeHeight"),
        .init(title: "수평 진폭", imageName: "horizontalAmplitude"),
        .init(title: "착지 측면 각도", imageName: "unknown"),
        .init(title: "오버스트라이드", imageName: "overstride")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        setupScrollLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    private func setupLayout() {
        view.addSubview(profileButton)
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        
        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            profileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileButton.widthAnchor.constraint(equalToConstant: 40),
            profileButton.heightAnchor.constraint(equalToConstant: 40),
            
            mainLabel.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 20),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 1),
            subLabel.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            subLabel.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor)
        ])
    }
    
    private func setupScrollLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // 세로 스크롤에서 반드시 필요
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        for (idx, item) in cards.enumerated() {
            let card = makeGuideCard(title: item.title, imageName: item.imageName)
            card.tag = idx
            card.addTarget(self, action: #selector(didTapGuideCard(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(card)
        }
    }
    

    private func makeGuideCard(title: String, imageName: String) -> FormGuideCardView {
        let card = FormGuideCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.heightAnchor.constraint(equalToConstant: 180).isActive = true
        card.configure(title: title, imageName: imageName)
        return card
    }
    
    
    @objc private func didTapProfile() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapGuideCard(_ sender: UIControl) {
        let idx = sender.tag
        print("선택:", cards[idx].title)
    }
    
}
