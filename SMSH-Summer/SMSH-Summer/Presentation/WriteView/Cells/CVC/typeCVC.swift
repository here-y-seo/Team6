//
//  typeCVC.swift
//  SMSH-Summer
//
//  Created by 강윤서 on 2022/08/28.
//

import UIKit

class typeCVC: UICollectionViewCell, UICollectionViewRegisterable {
    
    //MARK: - Properties
    static var isFromNib: Bool = false
    
    //MARK: - UI Components
    private lazy var typeImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = iv.frame.width / 2
        iv.clipsToBounds = true
        return iv
    }()
    
    private let plusButton: UIButton = {
        let btn = UIButton()
        btn.setImage(ImageLiterals.Write.plusBtn, for: .normal)
        return btn
    }()
    
    private var typeLabel: UILabel = {
        let lb = UILabel()
        lb.text = I18N.Write.plus
        lb.textColor = .Black
        lb.font = .AppleSDGothicNeoMedium(ofSize: 10)
        return lb
    }()
}

extension typeCVC {
    private func setLayout() {
        contentView.addSubviews(typeImageView, plusButton, typeLabel)
        
        typeImageView.snp.makeConstraints { make in
            make.top.leading.leading.equalToSuperview()
        }
        plusButton.snp.makeConstraints { make in
            make.center.equalTo(typeImageView.center)
        }
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(typeImageView.snp.bottom).offset(7)
            make.centerX.equalTo(typeImageView.snp.centerY)
        }
    }
}
