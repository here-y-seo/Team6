//
//  GoodDeed.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/08/28.
//

import UIKit

enum GoodDeedKind: String {
    case plogging
    case animals
    case donation
    case volunteer
    case etc
    
    func getMarkerImage() -> String {
        
        return "icon-\(self.rawValue)-mini-marker"
        
    }
    
    func getThumbnail() -> String {
        return "icon-\(self.rawValue)-mini"
    }
}

struct GoodDeed {
    var kind: GoodDeedKind
    var title: String
    var date: String
    var description: String?
    var lat: Double
    var lon: Double

}

extension GoodDeed {
    static var list: [GoodDeed] = [
        GoodDeed(kind: .plogging, title: "쓰레기 치우기", date: "8월 21일", description: "버스정류장 의자에 있던 음료컵을 근처 쓰레기통에 버림", lat: 37.547548, lon: 126.967790),
        GoodDeed(kind: .animals, title: "길고양이 물그릇 채우기", date: "7월 19일", description: "청파맨션 뒷쪽에 길고양이 집 앞에 있는 물그릇에 물이 없어 채워줌!", lat: 37.545687 , lon: 126.967123),
        GoodDeed(kind: .donation, title: "아름다운 가게에 옷 기부", date: "6월 30일", description: "이사 갈 겸 정리한 옷들을 아름다운 가게에 기부. 총 7만 8천원 나왔다.", lat: 37.543125, lon: 126.972879),
        GoodDeed(kind: .volunteer, title: "용문시장 행사 자원봉사", date: "7월 13일", description: "용문시장에서 열린 어린이들 사생대회에 스태프로 자원봉사 참여 ", lat: 37.535966, lon: 126.960263),
        
        GoodDeed(kind: .etc, title: "보호아동 자립지원 지지서명", date: "8월 12일", description: "시설 퇴소하는 보호아동의 자립지원 확장을 위한 지지서명을 함 ", lat: 37.553409, lon: 126.969734),

        GoodDeed(kind: .donation, title: "플라스틱 방앗간 후원", date: "8월 28일", description: "플라스틱 방앗간에서 만든 재사용 플라스틱 제품을 구매하고 3개월 후원 결제", lat: 37.547548, lon: 126.967790),
        
        GoodDeed(kind: .plogging, title: "러닝크루들과 플로깅", date: "6월 5일", description: "한강공원 4km를 함께 러닝하면서 플로깅", lat: 37.515996, lon: 126.975845)
    ]
}
