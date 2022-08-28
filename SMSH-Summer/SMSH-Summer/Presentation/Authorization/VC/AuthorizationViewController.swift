//
//  AuthorizationViewController.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/08/28.
//

import UIKit
import SnapKit
import Then

class AuthorizationViewController: UIViewController {
    // MARK: - Properties
    var titleLabel = UILabel().then {
        $0.font = .AppleSDGothicNeoBold(ofSize: 24)
        $0.textColor = .Black
        $0.text = "좋을지도 권한안내"
    }
    
    var descriptionLabel = UILabel().then {
        $0.font = .AppleSDGothicNeoMedium(ofSize: 14)
        $0.textColor = .DarkGray
        $0.numberOfLines = 2
        $0.text = "좋을지도는 아래 권한들을 필요로 합니다.\n서비스 사용 중 앱에서 요청 시 권한을 허용해주세요."
    }
    
    var firstSubtitleLabel = UILabel().then {
        $0.font = .AppleSDGothicNeoBold(ofSize: 14)
        $0.textColor = .secondaryColor
        $0.text = "필수 접근 권한"
    }
    var firstSubDescriptionLabel = UILabel().then {
        $0.font = .AppleSDGothicNeoMedium(ofSize: 14)
        $0.textColor = .DarkGray
        $0.numberOfLines = 2
        $0.text = "지도에서 내 위치를 확인하여 선행장소를 기록하는 데 권한이 필요합니다."
    }
    
    var secondSubtitleLabel = UILabel().then {
        $0.font = .AppleSDGothicNeoBold(ofSize: 14)
        $0.textColor = .secondaryColor
        $0.text = "선택 접근 권한"
    }
    var secondSubDescriptionLabel = UILabel().then {
        $0.font = .AppleSDGothicNeoMedium(ofSize: 14)
        $0.textColor = .DarkGray
        $0.numberOfLines = 2
        $0.text = "카메라와 앨범에서 사진을 선택해 선행 내용에 추가할 수 있습니다."
    }
    
    
    var okButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = .AppleSDGothicNeoBold(ofSize: 16)
        $0.tintColor = .white
        $0.backgroundColor = .secondaryColor
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setConstraints()
    }
    
    func setupUI() {
        view.addSubviews(titleLabel, descriptionLabel, firstSubtitleLabel, firstSubDescriptionLabel, secondSubtitleLabel, secondSubDescriptionLabel, okButton)
        view.backgroundColor = .white
        
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(48)
            
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            
        }
        
        firstSubtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(60)
        }
        
        firstSubDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstSubtitleLabel)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.top.equalTo(firstSubtitleLabel.snp.bottom).offset(6)
        }
        
        secondSubtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstSubDescriptionLabel)
            make.top.equalTo(firstSubDescriptionLabel.snp.bottom).offset(30)
        }
        
        secondSubDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(secondSubtitleLabel)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.top.equalTo(secondSubtitleLabel.snp.bottom).offset(6)
            
        }
        
        okButton.snp.makeConstraints { make in
            make.topMargin.greaterThanOrEqualTo(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(48)
        }
        
        
    }

}
