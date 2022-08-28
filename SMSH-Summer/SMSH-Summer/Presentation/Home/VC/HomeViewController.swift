//
//  HomeViewController.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/08/28.
//

import UIKit
import CoreLocation

import NMapsMap
import SnapKit
import Then

class HomeViewController: UIViewController {
    // MARK: - Properties
    /// Location - 위치관련 처리를 위해 싱글톤 객체 선언
    let locationManager = CLLocationManager()
    
    /// 콜렉션 뷰 데이터
    var list = GoodDeed.list
    
    /// 네이버지도 관련
    lazy var naverMapView = NMFMapView(frame: view.frame)
    
    /// - 기본 좌표 : 숙대
    var coord = NMGLatLng(lat: 37.545993, lng: 126.964707) {
        didSet {
            moveLocation()
        }
    }
    
    
    
    /// 현재 위치 버튼
    lazy var currentLocationButton = UIButton().then {
        $0.setImage(UIImage(named: "icon-current-location-on"), for: .normal)

        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 12
    }
    
    /// 콜렉션 뷰
    lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 14, left: 20, bottom: 28, right: 20)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 140
        let collectionView = UICollectionView(frame: .init(x: 0, y: screenHeight - height , width: screenWidth, height: height), collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        return collectionView
        
    }()
    
    let carouselCollectionView: UICollectionView = {
            
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.red

        return collectionView
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setConstraints()
        locationManager.delegate = self
        
        let locationOverlay = naverMapView.locationOverlay
        locationOverlay.hidden = true
        locationOverlay.location = coord
        locationOverlay.icon = NMFOverlayImage(name: "icon-location-overlay")
        
        moveLocation()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showRequestLocationServiceAlert()
    }
    
   
    // MARK: - Actions
    private func setActions() {
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
    }
    
    @objc func currentLocationButtonTapped(_ sender: UIButton) {
        
        /// 상태 따라서 이미지 변경
        sender.isSelected = !sender.isSelected
        let image = sender.isSelected ? "icon-current-location-on" :"icon-current-location-off"
        currentLocationButton.setImage(UIImage(named:image), for: .normal)
        
        /// 클릭하면 현재위치 받아오기
        locationManager.startUpdatingLocation()
        
        
    }
    
    // MARK: - Naver Map 설정
    func moveLocation() {
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .easeIn
        naverMapView.moveCamera(cameraUpdate)
        
    }
    
    // MARK: - Marker 설정
    func setMapMarker(_ data: GoodDeed) {
        /// 마커
        let marker = NMFMarker()
        marker.iconImage = NMFOverlayImage(name: data.kind.getMarkerImage())
        marker.captionText = data.title
        marker.position = NMGLatLng(lat: data.lat, lng: data.lon)
        marker.mapView = naverMapView
    
    }
    
    // MARK: - UI
    
    
    
    private func setLayout() {
        view.addSubviews(naverMapView, currentLocationButton, collectionView)
        
    }
    
    private func setConstraints() {
        naverMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-20)
            
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(182)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
}


// MARK: - 콜렉션 뷰 설정
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// 셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    /// 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        let data = list[indexPath.item]
        cell.configureData(data)
        setMapMarker(data)
        
        return cell
        
    }
    /// 셀 선택 시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = list[indexPath.item]
        
        coord = NMGLatLng(lat: data.lat, lng: data.lon)
    }
    
    /// 셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let inset: CGFloat = 20
        let spacing: CGFloat = 12
        
        let width: CGFloat = (screenWidth - inset - spacing) * 0.85
        
        let height: CGFloat = 140
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 20, bottom: 28, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    
    
}

// MARK: - 위치
/// 위치  및 위치 권한 관련 메서드 선언
extension HomeViewController {

    /// - 사용자가 위치서비스 권한이 켜져있는지
    func checkUserDeviceLocationServiceAuthorization() {
        /// -  권한상태
        let authorizationStatus: CLAuthorizationStatus
        
        /// - 15.0 이상 배포이므로 따로 iOS 버전에 대한 @available 체크를 하지는 않을 것
        authorizationStatus = locationManager.authorizationStatus
        
        /// - 현재 기기의 위치서비스 활성화 여부 체크
        if CLLocationManager.locationServicesEnabled() {
            /// - 위치서비스가 활성화 되어 있을 경우 위치권한 요청
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            showAlert("위치서비스가 꺼져있습니다.")
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus ) {
        
        switch authorizationStatus {
            
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
        case .restricted, .denied:
            showRequestLocationServiceAlert()

        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        default:
            print("Default")
        }
    }
    
    ///  - 설정창에서 위치정보를 키도록 유도
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            ///-  설정창으로 이동
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
    /// - 알림 창
    private func showAlert(_ title: String, buttonTitle: String = "확인") {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: title, style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
}
/// Location Manager Delegate
extension HomeViewController: CLLocationManagerDelegate {

    /// - 유저의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        if let location = locations.last?.coordinate as? CLLocationCoordinate2D  {
            let longitude: CLLocationDegrees = location.longitude
            let latitude: CLLocationDegrees = location.latitude
            
            coord = NMGLatLng(lat: latitude, lng: longitude)
        
        }
        
        locationManager.stopUpdatingLocation()
        
        
    }

    /// - 유저의 위치권한 상태가 변경될 때 / 위치 관리자를 생성할 경우
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
    
}

