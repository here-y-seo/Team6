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
    static let identifier = "typeCVC"
    
    //MARK: - UI Components
    
    private let plusButton: UIButton = {
        let btn = UIButton()
        btn.setImage(ImageLiterals.Write.plusBtn, for: .normal)
        btn.backgroundColor = .clear
        return btn
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}

extension typeCVC {
    private func setLayout() {
        contentView.addSubviews(plusButton)
        
        plusButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
