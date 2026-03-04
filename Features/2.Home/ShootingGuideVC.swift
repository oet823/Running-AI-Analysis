//
//  ShootingGuideVC.swift
//  RCA(Programmatic UI)
//
//  Created by 오은택 on 2/28/26.
//

import UIKit

//MARK: - Model
struct GuidePage {
    let title: String
    let imageName: String
}

//MARK: - ViewController
final class ShootingGuideVC: UIViewController {
    
    
    //MARK: - UI Components
    //촬영 가이드 레이블 선언
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "촬영 가이드"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorLine: UIView = {
        let v = UIView()
        v.backgroundColor = .label//시스템 블랙으로 해도 되는데 다크모드 떄문에
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var guideSegment: UISegmentedControl = {
        let seg = UISegmentedControl(items: pages.map { $0.title })
        seg.selectedSegmentIndex = 0
        seg.backgroundColor = .secondarySystemBackground
        seg.selectedSegmentTintColor = .systemCyan
        seg.translatesAutoresizingMaskIntoConstraints = false
        seg.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
        return seg
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        cv.dataSource = self
        cv.delegate = self
        cv.register(GuidePageCell.self, forCellWithReuseIdentifier: GuidePageCell.id)
        return cv
    }()
    
//MARK: - Data
    private let pages: [GuidePage] = [
        .init(title: "복장", imageName: "guide_clothes"),
        .init(title: "환경", imageName: "guide_environment"),
        .init(title: "측면", imageName: "guide_side"),
        .init(title: "수평", imageName: "guide_lev")
    ]
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavigation()
        setupLayout()
    }
    
    
//MARK: - Setup + Layout
    private func configureNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = ""
        navigationItem.largeTitleDisplayMode = .never //이거 설정해줘야 아래로 밀리는 현상 안 생김
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(separatorLine)
        view.addSubview(guideSegment)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            separatorLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            separatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            guideSegment.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 16),
            guideSegment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            guideSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            guideSegment.heightAnchor.constraint(equalToConstant: 36),
            
            collectionView.topAnchor.constraint(equalTo: guideSegment.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    
//MARK: - Actions
    @objc private func didChangeSegment() {
        let index = guideSegment.selectedSegmentIndex
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
//MARK: - Sync
    private func syncSegmentWithScroll() {
        let page = Int(round(collectionView.contentOffset.x / max(collectionView.bounds.width, 1)))
        guideSegment.selectedSegmentIndex = max(0, min(page, pages.count - 1))
    }
}


//MARK: - UICollectionView
extension ShootingGuideVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GuidePageCell.id, for: indexPath) as? GuidePageCell else {
            return UICollectionViewCell()
        }
        cell.configure(pages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        syncSegmentWithScroll()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        syncSegmentWithScroll()
    }
}
