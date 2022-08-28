//
//  writeVC.swift
//  SMSH-Summer
//
//  Created by 강윤서 on 2022/08/28.
//

import UIKit

class writeVC: UIViewController {

    // MARK: - UI Components
    private let writeTV: UITableView = {
        let tv = UITableView()
        tv.register(placeTVC.self, forCellReuseIdentifier: placeTVC.identifier)
        tv.register(typeTVC.self, forCellReuseIdentifier: typeTVC.identifier)
        tv.register(contentTVC.self, forCellReuseIdentifier: contentTVC.identifier)
        tv.allowsSelection = false
        return tv
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setDelegate()
        setLayout()
    }

}

// MARK: - Extension
extension writeVC {
    private func setUI() {
        let backButton = UIButton()
        backButton.setImage(ImageLiterals.Write.writeViewLeftBtn, for: .normal)
        backButton.tintColor = .Black
        
        let saveButton = UIButton()
        saveButton.setTitle(I18N.Write.navigation.save, for: .normal)
        saveButton.setTitleColor(.Black, for: .normal)
        saveButton.titleLabel?.font = .AppleSDGothicNeoRegular(ofSize: 14)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        self.navigationItem.title = I18N.Write.navigation.write
    }
    
    private func setLayout() {
        view.addSubviews(writeTV)
        
        writeTV.snp.makeConstraints { make in
            make.top.trailing.bottom.leading.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        writeTV.delegate = self
        writeTV.dataSource = self
    }
    
}

// MARK: - UITableViewDelegate

extension writeVC: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension writeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: placeTVC.identifier, for: indexPath) as? placeTVC else { return UITableViewCell() }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: typeTVC.identifier, for: indexPath) as? typeTVC else { return UITableViewCell() }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: contentTVC.identifier, for: indexPath) as? contentTVC else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.size.width
        
        switch indexPath.section {
        case 0:
            return width * 0.344
        case 1:
            return width * 0.38
        case 2:
            return 500
        default:
            return 200
        }
    }
}
