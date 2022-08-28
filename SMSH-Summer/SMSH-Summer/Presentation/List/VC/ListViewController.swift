//
//  ListViewController.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/08/28.
//

import UIKit
import SnapKit
import Then

class ListViewController: UIViewController {
    // MARK: - Properties
    /// 타이틀
    var titleLabel = UILabel().then {
        $0.font = .AppleSDGothicNeoBold(ofSize: 24)
        $0.text = "목록보기"
        $0.textColor = .Black
    }
    /// 필터
    var filterButton = UIButton().then {
        $0.setImage(UIImage(named: "icon-filter"), for: .normal)
    }
    
    /// 콜렉션 뷰 데이터
    var list = GoodDeed.list
    
    /// 콜렉션 뷰
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = UIScreen.main.bounds.height - 54

        let collectionView = UICollectionView(frame: .init(x: 0, y: 54, width: screenWidth, height: height), collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        
        return collectionView
        
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupUI()
        setConstraints()
    }
    
    // MARK: - Helpers
    
    func setupUI() {
        view.backgroundColor = .LightGray
        view.addSubviews(titleLabel, filterButton, collectionView)
    }
    
    func setConstraints() {
        
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        filterButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            
        }
        
    }

}


extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// 셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    /// 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureData(list[indexPath.item])
        
        return cell
    }
    
    /// 셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let inset: CGFloat = 20
        let width: CGFloat = screenWidth - (inset * 2)
        let height: CGFloat = 140
        
        return CGSize(width: width, height: height)
    }

}
