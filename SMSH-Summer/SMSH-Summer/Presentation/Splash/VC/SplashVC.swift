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
    }
    
    private let titleImage = UIImageView().then {
        $0.image = ImageLiterals.Splash.splashIcon
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
