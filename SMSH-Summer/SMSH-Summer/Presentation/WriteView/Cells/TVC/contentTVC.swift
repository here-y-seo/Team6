//
//  contentTVC.swift
//  SMSH-Summer
//
//  Created by 강윤서 on 2022/08/28.
//

import UIKit
import YPImagePicker

class contentTVC: UITableViewCell {
    
    // MARK: - Properties
  
    static let identifier = "contentTVC"
    
    // MARK: - UI Components
    
    private let contentTitle = UILabel().then {
        $0.text = I18N.Write.contentTitle
        $0.textColor = .Black
        $0.font = .AppleSDGothicNeoSemiBold(ofSize: 16)
    }
    
    private let titleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    private let titleLabel = UILabel().then {
        $0.text = I18N.Write.subTitle
        $0.textColor = .Black
        $0.font = .AppleSDGothicNeoMedium(ofSize: 13)
    }
    
    private let titleTextField = UITextField().then {
        let width = UIScreen.main.bounds.width
        let tfWidth = 335/width
        $0.placeholder = I18N.Write.placeholderTitle
        $0.borderStyle = .roundedRect
    }
    
    private let dateStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    private let dateLabel = UILabel().then {
        $0.text = I18N.Write.date
        $0.textColor = .Black
        $0.font = .AppleSDGothicNeoMedium(ofSize: 13)
    }
    
    private let datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .compact
    }
    
    private let explainStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    private let explainLabel = UILabel().then {
        $0.text = I18N.Write.explain
        $0.textColor = .Black
        $0.font = .AppleSDGothicNeoMedium(ofSize: 13)
        $0.setAttributedText(targetFontList: ["(선택)": .AppleSDGothicNeoMedium(ofSize: 10)], targetColorList: ["(선택)": .Gray])
    }
    
    private let explainTextField = UITextField().then {
        let width = UIScreen.main.bounds.width
        let tfWidth = 335/width
        $0.placeholder = I18N.Write.placeholderExplain
        $0.borderStyle = .roundedRect
    }
    
    private let photoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    private let photoLabel = UILabel().then {
        $0.text = I18N.Write.photo
        $0.textColor = .Black
        $0.font = .AppleSDGothicNeoMedium(ofSize: 13)
        $0.setAttributedText(targetFontList: ["(선택)": .AppleSDGothicNeoMedium(ofSize: 10)], targetColorList: ["(선택)": .Gray])
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

extension contentTVC {
    private func setStackView() {
        titleStackView.addArrangedSubviews(titleLabel, titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        dateStackView.addArrangedSubviews(dateLabel, datePicker)
        datePicker.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(0)
        }
        explainStackView.addArrangedSubviews(explainLabel, explainTextField)
        explainTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        photoStackView.addArrangedSubviews(photoLabel)
    }
    
    private func setLayout() {
        contentView.addSubviews(contentTitle, titleStackView, dateStackView, explainStackView, photoStackView)
        
        contentTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        titleStackView.snp.makeConstraints { make in
            make.top.equalTo(contentTitle.snp.bottom).offset(17)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        explainStackView.snp.makeConstraints { make in
            make.top.equalTo(dateStackView.snp.bottom).offset(22)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        photoStackView.snp.makeConstraints { make in
            make.top.equalTo(explainStackView.snp.bottom).offset(22)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
