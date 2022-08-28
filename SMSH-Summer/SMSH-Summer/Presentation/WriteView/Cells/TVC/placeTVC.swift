//
//  placeTVC.swift
//  SMSH-Summer
//
//  Created by 강윤서 on 2022/08/28.
//

import UIKit
import Then

class placeTVC: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "placeTVC"
  
    // MARK: - UI Components
    
    private let placeTitle = UILabel().then {
        $0.text = I18N.Write.placeTitle
        $0.textColor = .Black
        $0.font = .AppleSDGothicNeoSemiBold(ofSize: 16)
    }
    
    private let changePlaceBtn = UIButton().then {
        $0.setTitle(I18N.Write.changePlace, for: .normal)
        $0.titleLabel?.font = .AppleSDGothicNeoMedium(ofSize: 14)
        $0.setTitleColor(.Black, for: .normal)
        $0.backgroundColor = .clear
    }
    
    private let titleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    private let placeView = UIView().then {
        $0.backgroundColor = .LightGray
        $0.layer.cornerRadius = 8
    }
    
    private let placeLabel = UILabel().then {
        $0.text = "서울시 문정1동 363"
        $0.textColor = .textColor
        $0.font = .AppleSDGothicNeoMedium(ofSize: 15)
    }
  
    // MARK: - Life Cycle Part

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStackView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Methods

extension placeTVC {
    
    private func setStackView() {
        titleStackView.addArrangedSubviews(placeTitle, changePlaceBtn)
    }
    
    private func setLayout() {
        
        self.contentView.addSubviews(titleStackView, placeView, placeLabel)

        titleStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }

        placeView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(18)
            make.trailing.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(22)
        }
        
        placeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(placeView)
        }
    }
}
