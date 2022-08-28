//
//  typeTVC.swift
//  SMSH-Summer
//
//  Created by 강윤서 on 2022/08/28.
//

import UIKit

class typeTVC: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "typeTVC"
  
    // MARK: - UI Components
    
    private let typeTitle = UILabel().then {
        $0.text = I18N.Write.typeTitle
        $0.textColor = .Black
        $0.font = .AppleSDGothicNeoSemiBold(ofSize: 16)
    }
    
    private lazy var typeCV: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.bounces = false
        cv.register(typeCVC.self, forCellWithReuseIdentifier: typeCVC.identifier)
        
        return cv
        
    }()
  
    // MARK: - Life Cycle Part

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setDelegate()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension typeTVC {
    private func setLayout() {
        self.contentView.addSubviews(typeTitle, typeCV)
        
        typeTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
        typeCV.snp.makeConstraints { make in
            make.top.equalTo(typeTitle.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(22)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setDelegate() {
        typeCV.delegate = self
        typeCV.dataSource = self
    }
}

extension typeTVC: UICollectionViewDelegate{
    
}

extension typeTVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: typeCVC.identifier, for: indexPath) as? typeCVC else {return UICollectionViewCell()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        
        let cellWidth = width * (50/375)
        let cellHeight = cellWidth * (67/48)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
}

extension typeTVC: UICollectionViewDelegateFlowLayout{
    
}
