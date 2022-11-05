//
//  SettingView.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/11/05.
//

import UIKit
import SnapKit
import Then

class SettingView: UIView {

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout() ).then {
        
        $0.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .systemBackground
            
            setupUI()
            setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(collectionView)
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
