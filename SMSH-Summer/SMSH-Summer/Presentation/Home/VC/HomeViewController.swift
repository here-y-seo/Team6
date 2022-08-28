//
//  HomeViewController.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/08/28.
//

import UIKit
import NMapsMap
import SnapKit
import Then

class HomeViewController: UIViewController {
    // MARK: - Properties
    
    /// 네이버지도
    lazy var naverMapView = NMFMapView(frame: view.frame)
    
    /// 현재 위치 버튼
    lazy var currentLocationButton = UIButton().then {
        $0.setImage(UIImage(named: "icon-current-location-on"), for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.LightGray.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 12
    }
    
    /// 콜렉션 뷰

    
    lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 14, left: 20, bottom: 28, right: 20)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 140
        let collectionView = UICollectionView(frame: .init(x: 0, y: screenHeight - height , width: screenWidth, height: height), collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        return collectionView
        
    }()
    
    let carouselCollectionView: UICollectionView = {
            
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.red

        return collectionView
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setConstraints()
    }
    
    
    private func setLayout() {
        view.addSubviews(naverMapView, currentLocationButton, collectionView)
        
    }
    
    private func setConstraints() {
        naverMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-20)
            
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(182)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
    }
}


// MARK: - 콜렉션 뷰 설정
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// 셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    /// 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
        
    }
    
    /// 셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let inset: CGFloat = 20
        let spacing: CGFloat = 12
        
        let width: CGFloat = (screenWidth - inset - spacing) * 0.85
        
        let height: CGFloat = 140
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 20, bottom: 28, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
}



