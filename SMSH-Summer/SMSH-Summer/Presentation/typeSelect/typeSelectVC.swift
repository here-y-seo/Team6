//
//  typeSelectVC.swift
//  SMSH-Summer
//
//  Created by 강윤서 on 2022/08/28.
//

import UIKit

class typeSelectVC: UIViewController {

    // MARK: - Properties
    private var typeBtn: [UIButton] = []
    
    // MARK: - UI Components
    private let typeSelectView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private let selectTitleLabel = UILabel().then {
        $0.text = "종류선택"
        $0.textColor = .Black
        $0.font = .AppleSDGothicNeoBold(ofSize: 16)
    }
    
    private let btnStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 24
        $0.distribution = .fillEqually
        $0.alignment = .leading
    }
    
    private let ploggingBtn = UIButton().then {
        $0.setImage(ImageLiterals.Write.ploggingDisableBtn, for: .normal)
        $0.setImage(ImageLiterals.Write.ploggingBtn, for: .selected)
        $0.backgroundColor = .clear
    }
    
    private let animalBtn = UIButton().then {
        $0.setImage(ImageLiterals.Write.animalDisable, for: .normal)
        $0.setImage(ImageLiterals.Write.animalBtn, for: .selected)
        $0.backgroundColor = .clear
    }
    
    private let donationBtn = UIButton().then {
        $0.setImage(ImageLiterals.Write.donationDisableBtn, for: .normal)
        $0.setImage(ImageLiterals.Write.donationBtn, for: .selected)
        $0.backgroundColor = .clear
    }
    
    private let volunteerBtn = UIButton().then {
        $0.setImage(ImageLiterals.Write.volunteerDisableBtn, for: .normal)
        $0.setImage(ImageLiterals.Write.volunteerBtn, for: .selected)
        $0.backgroundColor = .clear
    }
    
    private let etcBtn = UIButton().then {
        $0.setImage(ImageLiterals.Write.etcDisableBtn, for: .normal)
        $0.setImage(ImageLiterals.Write.etcBtn, for: .selected)
        $0.backgroundColor = .clear
    }
    
    private let selectBtn = UIButton().then {
        $0.setTitle("선택", for: .normal)
        $0.titleLabel?.font = .AppleSDGothicNeoBold(ofSize: 16)
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .primaryColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setStackView()
        setLayout()
    }

}

extension typeSelectVC {
    private func setUI() {
        self.view.backgroundColor = .clear.withAlphaComponent(60)
    }
    
    private func setStackView() {
        btnStackView.addArrangedSubviews(ploggingBtn, animalBtn,
                                         donationBtn, volunteerBtn, etcBtn)
    }
    
    private func setLayout() {
        view.addSubviews(typeSelectView)
        typeSelectView.addSubviews(selectTitleLabel, btnStackView, selectBtn)
        
        typeSelectView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.31)
            make.leading.trailing.equalToSuperview()
            make.width.bottom.equalToSuperview()
        }
        
        selectTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(295)
        }
        btnStackView.snp.makeConstraints { make in
            make.top.equalTo(selectTitleLabel.snp.bottom).offset(17)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        selectBtn.snp.makeConstraints { make in
            make.top.equalTo(btnStackView.snp.bottom).offset(30)
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(19)
        }
    }
    
}
