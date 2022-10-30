//
//  WriteLocationVC.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/08/28.
//

import UIKit
import NMapsMap
import CoreLocation

class WriteLocationVC: UIViewController {
    // MARK: - Properties
    
    let locationManager = CLLocationManager()

    /// 네이버지도 관련
    lazy var naverMapView = NMFMapView(frame: view.frame)
    
    /// 기본 좌표 : 숙대
    var coord = NMGLatLng(lat: 37.545993, lng: 126.964707) {
        didSet {
            moveLocation()
        }
    }
    var location: String = "" {
        didSet {
            addressLabel.text = location
        }
    }
    
    /// 현재 위치 버튼
    let currentLocationButton = UIButton().then {
        $0.setImage(UIImage(named: "icon-current-location-on"), for: .normal)

        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 12
    }
    
    /// 레이업뷰
    let layupView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 12
    }
    
    /// 타이틀
    let titleLabel = UILabel().then {
        $0.font = .AppleSDGothicNeoBold(ofSize: 20)
        $0.textColor = .Black
        $0.text = "선행 장소"
    }
    
    /// 주소텍스트 베이스뷰
    let addressLabelBaseView = UIView().then {
        $0.backgroundColor = .LightGray
        $0.layer.cornerRadius = 8
    }
    
    /// 주소텍스트
    let addressLabel = UILabel().then {
        $0.font = .AppleSDGothicNeoMedium(ofSize: 16)
        $0.minimumScaleFactor = 0.8
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = .Black
        $0.text = "원하는 위치를 선택해주세요"
        $0.textAlignment = .center
    }
    
    /// 온라인 버튼
    let onlineButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitleColor(.darkGray, for: .normal)
        $0.setTitle("온라인으로 했어요", for: .normal)
        $0.titleLabel?.font = .AppleSDGothicNeoSemiBold(ofSize: 14)

    }
    
    /// 여기서 했어요 버튼
    let didHereButton = UIButton().then {
        $0.backgroundColor = .primaryColor
        $0.setTitle("여기서 좋은 일을 했어요!", for: .normal)
        $0.titleLabel?.font = .AppleSDGothicNeoSemiBold(ofSize: 14)
        $0.tintColor = .Black
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setConstraints()
        
        locationManager.delegate = self
        naverMapView.touchDelegate = self
        
        //self.tabBarController?.tabBar.layer.zPosition = -1
        self.tabBarController?.tabBar.isHidden = true
        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.title = "등록하기"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissButtonTapped(_:)))
        
        onlineButton.addTarget(self, action: #selector(onlineButtonTapped), for: .touchUpInside)
        didHereButton.addTarget(self, action: #selector(goNextWritePageButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.tabBarController?.tabBar.isHidden = false
        view.layoutIfNeeded()
    }
    
    @objc func goNextWritePageButtonTapped(_ sender: UIButton) {
        let vc = writeVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onlineButtonTapped(_ sender: UIButton) {
        location = "온라인"
    }
    
    // MARK: - Naver Map 설정
    func moveLocation() {

        let locationOverlay = naverMapView.locationOverlay
        locationOverlay.hidden = true
        locationOverlay.location = coord
        locationOverlay.icon = NMFOverlayImage(name: "icon-location-overlay")

        
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .easeIn
        naverMapView.moveCamera(cameraUpdate)
        
    }
    
    // MARK: - Helpers
    func setLayout() {
        view.addSubviews(naverMapView, currentLocationButton, layupView)
        layupView.addSubviews(titleLabel, addressLabelBaseView, onlineButton, didHereButton, onlineButton)
        addressLabelBaseView.addSubviews(addressLabel)
    }
    
    func setConstraints() {
        naverMapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-20)
            
        }
        
        layupView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(300)
            
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(24)
            
        }
        addressLabelBaseView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.centerY.equalToSuperview()
            
        }
        
        didHereButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(onlineButton)
            make.height.equalTo(54)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
        onlineButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(didHereButton.snp.top).offset(-10)
            make.height.equalTo(44)
        }
        
    }

}

/// Location Manager Delegate
extension WriteLocationVC: CLLocationManagerDelegate {

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
    
}


extension WriteLocationVC: NMFMapViewTouchDelegate {
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("\(latlng.lat), \(latlng.lng)")
        coord = latlng
        
        GeocodingManager.shared.callReversedGeocoding(lon: "\(latlng.lng)", lat: "\(latlng.lat)", completionHandler: { address in
            DispatchQueue.main.async {
                
                self.location = address
            }
        })

    }
}
