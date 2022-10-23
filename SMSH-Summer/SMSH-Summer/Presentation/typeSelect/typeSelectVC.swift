//
//  typeSelectVC.swift
//  SMSH-Summer
//
//  Created by 강윤서 on 2022/08/28.
//

import UIKit
import PanModal

class typeSelectVC: UIViewController {

    // MARK: - Properties
    private var typeBtn: [UIButton] = []
    // var delegate: SelectedTypeProtocol?
    
    // MARK: - UI Components
    private let selectTitleLabel = UILabel().then {
        $0.text = "종류선택"
        $0.textColor = .Black
        $0.font = .AppleSDGothicNeoBold(ofSize: 16)
    }
    
    private let btnStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .equalSpacing
        $0.alignment = .center
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
        view.backgroundColor = .white
        typeBtn = [ploggingBtn, animalBtn,
                   donationBtn, volunteerBtn, etcBtn]
    }
    
    private func setStackView() {
        view.addSubviews(selectTitleLabel, btnStackView, selectBtn)
        typeBtn.forEach {
            btnStackView.addArrangedSubviews($0)
        }
    }
    
    private func setLayout() {

        selectTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(24)
        }
        
        btnStackView.snp.makeConstraints { make in
            make.top.equalTo(selectTitleLabel.snp.bottom).offset(17)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        selectBtn.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(btnStackView.snp.bottom).offset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}

// MARK: - Pan Modal
extension typeSelectVC: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(220)
    }
    var longFormHeight: PanModalHeight {
        return .contentHeight(220)
    }
    
}
