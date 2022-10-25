//
//  GoodDeedModel.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/10/26.
//

import Foundation
import RealmSwift

class GoodDeedModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId // PK
    @Persisted var lat: Double
    @Persisted var lon: Double
    @Persisted var kind: GoodDeedKind.RawValue // 선행종류
    @Persisted var date: Date // 날짜
    @Persisted var title: String // 제목
    @Persisted var userDescription: String // 설명
    @Persisted var images: List<String> // 이미지위치가 저장되는 배열

    convenience init(lat: Double, lon: Double, kind: GoodDeedKind, date: Date, title: String, userDescription: String, images: [String] ) {
        self.init()
        self.lat = lat
        self.lon = lon
        self.kind = kind.rawValue
        self.date = date
        self.title = title
        self.userDescription = userDescription
        self.images.append(objectsIn: images)
    }
}
