//
//  WriteLocationVC.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/08/28.
//

import UIKit
import NMapsMap

class WriteLocationVC: UIViewController {
    // MARK: - Properties
    
    /// 네이버지도 관련
    lazy var naverMapView = NMFMapView(frame: view.frame)
    
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
        $0.textColor = .Black
        $0.text = "서울시 문정1동 363"
        $0.textAlignment = .center
    }
    
    /// 온라인 버튼
    let onlineButton = UIButton().then {
        $0.backgroundColor = .white
        $0.tintColor = .DarkGray
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
    }
    
    // MARK: - Actions
    
    
    // MARK: - Helpers
    func setLayout() {
        view.addSubviews(naverMapView, currentLocationButton, layupView)
        layupView.addSubviews(titleLabel, addressLabelBaseView, onlineButton, didHereButton)
        addressLabelBaseView.addSubviews(addressLabel)
    }
    
    func setConstraints() {
        naverMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(24)
            
        }
        addressLabelBaseView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerX.centerY.equalToSuperview()
            
        }
        
        onlineButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(addressLabelBaseView.snp.bottom).offset(24)
            make.height.equalTo(48)
        }
        didHereButton.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(onlineButton)
            make.top.equalTo(onlineButton.snp.bottom)
            
        }
        
        
        
    }

}
