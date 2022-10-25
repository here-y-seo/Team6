//
//  GoodDeedRepository.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/10/26.
//

import Foundation
import RealmSwift

fileprivate protocol GoodDeedRepositoryType: AnyObject {
    func fetch() -> Results<GoodDeedModel>
    func filteredFetch(query: String) -> Results<GoodDeedModel>
    func createDeed(_ item: GoodDeedModel)
    func updateDeed(_ item: GoodDeedModel)
}

class GoodDeedRepository: GoodDeedRepositoryType {
    static let shared = GoodDeedRepository()
    
    let localRealm = try! Realm()
    
    /// 선행 데이터 가져오기
    func fetch() -> Results<GoodDeedModel> {
        return localRealm.objects(GoodDeedModel.self).sorted(byKeyPath: "date", ascending: false) // 최신순으로 가져오기
    }
    
    /// 제목 또는 설명으로 선행 검색
    func filteredFetch(query: String) -> Results<GoodDeedModel> {
        let tasks = localRealm.objects(GoodDeedModel.self)
        let results = tasks.where {
            // 제목, 설명으로 검색
            $0.title.contains(query, options: .caseInsensitive) ||
            $0.userDescription.contains(query, options: .caseInsensitive)
        }
        
        return results
    }
    
    /// 선행 추가
    func createDeed(_ item: GoodDeedModel) {
        do {
            try localRealm.write  {
                localRealm.add(item)
            }
        } catch let error {
            print(error) //사용자에게 에러알림 해줄 수 있게 처리하기
        }
    }
    
    /// 선행 업데이트
    func updateDeed(_ item: GoodDeedModel) {
        do {
            try self.localRealm.write {
                localRealm.add(item, update: .modified)
                
            }
        } catch let error {
            print(error)
        }
    }
    
    /// 선행 삭제
    func deleteDeed(_ item: GoodDeedModel) {
        do {
            try localRealm.write {
                localRealm.delete(item)
            }
        } catch let error {
            print(error)
        }
    }
    
}
