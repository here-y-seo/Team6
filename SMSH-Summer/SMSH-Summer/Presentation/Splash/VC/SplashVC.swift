//
//  SplashVC.swift
//  SMSH-Summer
//
//  Created by 강윤서 on 2022/08/28.
//

import UIKit
import SnapKit
import Then

class SplashVC: UIViewController {
    
    // MARK: - UI Components
    
    private let splashView = UIView().then {
        $0.backgroundColor = .secondaryColor
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.text = I18N.Splash.title
        $0.font = .GhanaRegular(ofSize: 44)
        $0.numberOfLines = 2
    }
    
    private let logoImage = UIImageView().then {
        $0.image = ImageLiterals.Splash.splashIcon
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }

}

// MARK: Extension

extension SplashVC {
    private func setLayout() {
        view.addSubviews(splashView)
        splashView.addSubviews(titleLabel, logoImage)
        
        splashView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(70)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(67)
        }
        
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(11)
            make.leading.equalToSuperview().inset(52)
        }
    }
}
