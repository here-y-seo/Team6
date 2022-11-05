//
//  SettingViewController.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/11/05.
//

import UIKit
import SwiftUI

enum SettingInfo: Int, CaseIterable {
    case VersionInfo = 0
    case EmailFeedback = 1
    case OpensourceLicense = 2
    
    func getString() -> String {
        switch self {
        case .VersionInfo:
            return "버전 정보"
        case .EmailFeedback:
            return "앱 피드백 및 문의"
        case .OpensourceLicense:
            return "오픈소스 라이선스"
        }
    }
}

final class SettingViewController: UIViewController {
    
    let mainView = SettingView()
    typealias Item = SettingInfo
    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>!
    // 버전정보
    public var version: String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String else { return nil }
        
        return version
    }
    
    // lifecycle
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        configure()
        setNavigationBar()

    }
    
    func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.collectionViewLayout = createLayout()
        configureDataSource()
    }
    
    func setNavigationBar() {
        navigationItem.title = "설정"
    }

}
// 컴포지셔널 레이아웃 설정
extension SettingViewController {
    /// 콜렉션뷰 컴포지셔널 레이아웃 설정
    private func createLayout() -> UICollectionViewLayout {
        
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.showsSeparators = true
                
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }
    
    /// Diffable datasource
    private func configureDataSource() {
        // 셀 등록
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SettingInfo> { [weak self] cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            
            content.textProperties.font = .AppleSDGothicNeoMedium(ofSize: 15)
            
            content.text = itemIdentifier.getString()
            if itemIdentifier == .VersionInfo {
                if let version = self?.version {
                    content.secondaryText = version
                }
            }
            
            content.prefersSideBySideTextAndSecondaryText = true

            cell.contentConfiguration = content
        }
        
        // Diffable Data Source
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(SettingInfo.allCases)
        
        dataSource.apply(snapshot)
    }
}

extension SettingViewController: UICollectionViewDelegate {
    
}
