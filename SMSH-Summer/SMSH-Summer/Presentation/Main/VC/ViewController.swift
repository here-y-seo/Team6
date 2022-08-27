//
//  ViewController.swift
//  SMSH-Summer
//
//  Created by 강윤서 on 2022/08/27.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var helloText: UILabel = {
        let st = UILabel()
        st.font = .AppleSDGothicNeoBold(ofSize: 10)
        st.text = "하이"
        st.textColor = .primaryColor
        return st
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
}

extension ViewController {
    private func setLayout() {
        view.addSubview(helloText)
        
        helloText.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

