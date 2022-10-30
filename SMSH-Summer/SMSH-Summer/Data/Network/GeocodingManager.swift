//
//  GeocodingManager.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/10/30.
//

import Foundation
import Alamofire

class GeocodingManager {
    private init() {}
    static let shared = GeocodingManager()
    
    typealias reverseGeocodingCompletionHandler = (String) -> Void
    
    func callReversedGeocoding(lon: String, lat: String, completionHandler: @escaping reverseGeocodingCompletionHandler) {
        let url = Endpoints.ReverseGeocodingURL
        let header: HTTPHeaders = [
            "X-NCP-APIGW-API-KEY-ID" : Keys.Naver_ID,
            "X-NCP-APIGW-API-KEY" : Keys.Naver_Secret
        ]
        let param: Parameters = [
            "coords": "\(lon),\(lat)", // 쿼리
            "output": "json", // 받아오는 형태: JSON
            "orders": "roadaddr" // 좌표 -> 도로명주소 변환
        ]
        
        AF.request(url, method: .get, parameters: param, headers: header).validate().responseDecodable(of: ReversedGeocoding.self, queue: .global()) { response in
            
            switch response.result {
            case .success(let value):
                if !value.results.isEmpty{
                    let address = value.results[0].region
                    let detail = value.results[0].land
                    let addressString = address.area1.alias + " " + address.area2.name + " " + detail.name + " " + detail.number1 + " " + detail.addition0.value
                    completionHandler(addressString)
                } else {
                    completionHandler("정보 없음")
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

