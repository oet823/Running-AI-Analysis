

import MapKit
import CoreLocation
import UIKit

//MARK: - MapKit
final class HomeVC: UIViewController { //final -> 더 이상 상속 못하게 선언)
    
    private let mapView: MKMapView = {
        let v = MKMapView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isRotateEnabled = false
        v.showsUserLocation = true
        return v
    }()
    
    private let mapMaskOverlayView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        v.isUserInteractionEnabled = false
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
//MARK: - UI
    private let locationManager = CLLocationManager()
    
    private let profileButton: UIButton = { //private -> HomeVC 안에서만 가능
        let button = UIButton(type: .system) //iOS가 제공하는 기본 버튼 스타일 채택
        let image = UIImage(systemName: "person.crop.circle")
        button.setImage(image, for: .normal)
        button.tintColor = .label //.label -> 일반모드에서 검은색, 다크 모드에서 흰색
        button.translatesAutoresizingMaskIntoConstraints = false //오토레이아웃 끄고 내가 코드로만 설정할거
        
        let config = UIImage.SymbolConfiguration(pointSize: 36, weight: .regular)
        button.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        
        return button
    }()//클로저
    
    private let shootingGuideButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("촬영 가이드", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        
        //"글씨만" 보이게 (배경 테두리 제거)
        button.backgroundColor = .clear //배경색을 투명하게
        button.layer.borderWidth = 0 //테두리 선을 아예 없애버림
        button.contentEdgeInsets = .zero //
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .semibold)
        label.textColor = .label
        label.text = "안녕하세요 오은택님!"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .label
        label.text = "오늘도 힘차게 달려볼까요?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     private let startButton: UIButton = {
         let button = UIButton(type: .system)
         
         button.setTitle("시작", for: .normal)
         button.setTitleColor(.black, for: .normal)
         button.titleLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
         
         button.backgroundColor = UIColor(red: 135/255,green: 206/255, blue: 250/255, alpha: 1) //sky 느낌
         button.layer.cornerRadius = 75
         button.layer.masksToBounds = true
         
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
     
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigation()
        setupLayout()
        setupActions()
        setupLocation()
        
        // 네비게이션바 숨기면 safe area가 노치쪽으로 올라감 개이득
        //navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
//MARK: - Configure
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        view.addSubview(mapMaskOverlayView)
    }
    
    private func configureNavigation() {
        // RootTabBarController에서 UINavigationController로 감싸져 있으니까 여기서 숨기면 됨
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
//MARK: - Location
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
//MARK: - Layout
    private func setupLayout() {
        setupMapLayout()
        setupTopBar()
        setupStartButton()
    }
    
    private func setupMapLayout() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        NSLayoutConstraint.activate([
            mapMaskOverlayView.topAnchor.constraint(equalTo: mapView.topAnchor),
            mapMaskOverlayView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            mapMaskOverlayView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            mapMaskOverlayView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor)
        ])
    }
    
// MARK: - Spotlight 시작버튼
    
    
    private func setupTopBar() {
        view.addSubview(profileButton)
        view.addSubview(shootingGuideButton)
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        
        
        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            profileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileButton.widthAnchor.constraint(equalToConstant: 40),
            profileButton.heightAnchor.constraint(equalToConstant: 40),
            
            shootingGuideButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            shootingGuideButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mainLabel.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 20),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 3),
            subLabel.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            subLabel.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor)
        ])
    }
    
    private func setupStartButton() {
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -170),
            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
// MARK: - Actions
    private func setupActions() {
        profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        shootingGuideButton.addTarget(self, action: #selector(didTapShootingGuide), for: .touchUpInside)
    }
    
    @objc private func didTapProfile() {
        let vc = ProfileVC()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapShootingGuide() {
        let vc = ShootingGuideVC()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - CLLocationManagerDelegate

extension HomeVC: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            mapView.showsUserLocation = true
        case .denied, .restricted: break //권한 거부 상태 (필요하면 안대 UI 띄우기)
        case .notDetermined:break //아직 선택 전
            
        @unknown default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        
        let region  = MKCoordinateRegion( //현재 위치로 지도 이동
            center: location.coordinate,
            latitudinalMeters: 500,
            longitudinalMeters: 500
        )
        mapView.setRegion(region, animated: true)
        
        manager.stopUpdatingLocation() //배터리 아끼려면 한 번 이동 후 꺼도 됨
    }
}
