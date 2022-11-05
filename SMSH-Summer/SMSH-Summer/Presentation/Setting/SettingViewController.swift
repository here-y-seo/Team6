//
//  SettingViewController.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/11/05.
//

import UIKit
import MessageUI
import SafariServices

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
    
    func getImage() -> String {
        switch self {
        case .VersionInfo:
            return "info.circle.fill"
        case .EmailFeedback:
            return "envelope.open.fill"
        case .OpensourceLicense:
            return "quote.opening"
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
            content.image = UIImage(systemName: itemIdentifier.getImage())
            content.imageProperties.tintColor = .primaryColor
            
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
        case SettingInfo.VersionInfo.rawValue:
            // 버전정보 노션 연결
            webButtonTapped(SettingInfo.VersionInfo)
            
        case SettingInfo.EmailFeedback.rawValue:
            // 이메일 문의 안내
            feedbackButtonTapped()
            
        case SettingInfo.OpensourceLicense.rawValue:
            // 오픈소스라이센스 노션
            webButtonTapped(SettingInfo.OpensourceLicense)
            
        default:
            break
        }
    }
}
// 셀 선택 시 적용되는 메서드
extension SettingViewController {
    /// 웹 열기
    func webButtonTapped(_ kind: SettingInfo) {
        
        var link: String = ""
        switch kind {
        case .VersionInfo:
            link = "https://www.notion.so/kimdee/0475ca74ec4640bdb4678c6b118a0958"
        case .OpensourceLicense:
            link = "https://kimdee.notion.site/be989f6e15d240f0832f9f060766ca40"
        default:
            return
        }
        
        guard let url = URL(string: link) else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    /// 메일 보내기
    func feedbackButtonTapped() {
        // 이메일창이 나타나는 컨트롤러
        guard MFMailComposeViewController.canSendMail() else {
            // 사용자의 메일 계정이 설정되어 있지 않아 메일을 보낼 수 없다는 경고 메시지 추가
            print("메일 보내기 실패")
            let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "메일을 보내려면 'Mail' 앱이 필요합니다. App Store에서 해당 앱을 복원하거나 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
            let goAppStoreAction = UIAlertAction(title: "App Store로 이동하기", style: .default) { _ in
                // 앱스토어로 이동하기(Mail)
                if let url = URL(string: "https://apps.apple.com/kr/app/mail/id1108187098"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            let cancleAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            
            sendMailErrorAlert.addAction(goAppStoreAction)
            sendMailErrorAlert.addAction(cancleAction)
            self.present(sendMailErrorAlert, animated: true, completion: nil)
            return
        }
        
        
        let emailTitle = "[좋을지도] 피드백 및 문의" // 메일 제목
        let messageBody =
                    """
                    🔨 OS Version: \(UIDevice.current.systemVersion)
                    🔨 Device: \(UIDevice.current.localizedModel)
                    🔨 App Version: \(self.getCurrentVersion())
                    ----------------------------------------
                    🔨 내용:
                    좋을지도 앱 문의, 버그 신고, 피드백 내용에 대해 입력해주세요.
                    스크린샷을 함께 첨부해주시면 큰 도움이 됩니다. 🙇‍♂️
                    
                    
                    """
        // 3
        let toRecipents = ["kimdee.dev@gmail.com"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)
        
        self.present(mc, animated: true, completion: nil)
    }
    
    // 4
    @objc(mailComposeController:didFinishWithResult:error:)
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult,error: Error?) {
        controller.dismiss(animated: true)
    }
    
    /// 앱의 버전정보 가져오기
    func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }
}
extension SettingViewController: MFMailComposeViewControllerDelegate {
}

