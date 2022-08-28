//
//  HomeCollectionViewCell.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/08/28.
//

import UIKit
import SnapKit
import Then

class HomeCollectionViewCell: UICollectionViewCell {
   // MARK: - Properties
    static let identifier = "HomeCollectionViewCell"
    
    
    var thumbnail = UIImageView().then {
        $0.image = UIImage(named: "icon-loading-mini" )
    }
    var locationIcon = UIImageView().then {
        $0.image = UIImage(named: "icon-location-mini")
    }
    
    var calendarIcon = UIImageView().then {
        $0.image = UIImage(named: "icon-calendar-mini")
    }
    
    var titleLabel = UILabel().then {
        $0.font = .AppleSDGothicNeoBold(ofSize: 18)
        $0.numberOfLines = 1
        $0.text = "쓰레기 버리기"
        $0.textColor = .Black
    }
    var descriptionLabel = UILabel().then {
        $0.font = .AppleSDGothicNeoRegular(ofSize: 14)
        $0.numberOfLines = 2
        $0.textColor = .DarkGray
        $0.text = "버스정류장 의자에 있던 음료컵을 근처에 있는 쓰레기통에 버림"
    }
    
    var locationLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = .AppleSDGothicNeoRegular(ofSize: 11)
        $0.text = "472m"
        $0.textColor = .DarkGray
    }
    var dateLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = .AppleSDGothicNeoRegular(ofSize: 11)
        $0.text = "4시간 전"
        $0.textColor = .DarkGray
    }
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    // MARK: - Helpers
    
    func configureData(_ data: GoodDeed) {
        thumbnail.image = UIImage(named: data.kind.getThumbnail())
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        locationLabel.text = "\(Int.random(in: 300...987)) m" // 위경도로 수정
        dateLabel.text = data.date
    }
    
    func setupUI() {
        
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.LightGray.cgColor
        self.contentView.layer.shadowOpacity = 0.1
        self.contentView.layer.shadowRadius = 12
        
        self.contentView.addSubviews(thumbnail, locationIcon, calendarIcon, titleLabel, descriptionLabel, locationLabel, dateLabel)
       
    }
    func setConstraints() {
        thumbnail.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.topMargin.equalTo(12)
            make.leadingMargin.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(thumbnail.snp.trailing).offset(10)
            make.centerY.equalTo(thumbnail.snp.centerY)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(thumbnail)
            make.top.equalTo(thumbnail.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        calendarIcon.snp.makeConstraints { make in
            make.leading.equalTo(thumbnail)
            make.bottomMargin.equalToSuperview().offset(-16)
            make.width.height.equalTo(16)
            make.topMargin.greaterThanOrEqualTo(descriptionLabel.snp.bottom).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(calendarIcon.snp.centerY)
            make.leading.equalTo(calendarIcon.snp.trailing).offset(6)
        }
        
        locationIcon.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing).offset(16)
            make.width.height.equalTo(calendarIcon)
            make.centerY.equalTo(dateLabel.snp.centerY)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(locationIcon.snp.trailing).offset(6)
            make.centerY.equalTo(locationIcon.snp.centerY)
            make.trailing.greaterThanOrEqualToSuperview().offset(-20)
            
        }
        
    }
    
    
    
}
