//
//  LocationRepository.swift
//  WeatherForecast
//
//  Created by MAC GNC on 2024/06/06.
//

import Alamofire
import CoreLocation
import Foundation

fileprivate typealias Json = [String: Any]

class LocationRepository {
    
    // 위도, 경도를 받아서 Kakao 역지오코딩 API를 통해 행정동 정보를 받습니다
    func getMyLocationByLatLng(lat: Double, lng: Double, completionHandler: @escaping (LocationData) -> Void) {
        AF.request(_getKakaoReverseGeocodingApiUrl(lat: lat, lng: lng), headers: _getKakaoAuthHeaders()).validate(statusCode: 200..<500).response { response in
            guard let _ = response.data else { return } // 오류도 반환
            
            if let jsonData = try? JSONSerialization.jsonObject(with: response.data!) as? Json {
                let administrativeData = (jsonData["documents"] as! [Json]).first(where: {
                    $0["region_type"] as! String == "H"
                })
                
                if let _ = administrativeData {
                    completionHandler(self._toLocationData(administrativeData!))
                } else {
                    return  // throw error
                }
            }
        }
    }
    
    fileprivate func _toLocationData(_ data: [String: Any]) -> LocationData {
        let administrativeFilePath = "\(Bundle.main.resourcePath!)/Administrative.csv"
        let administrativeDataList = try! String(contentsOfFile: administrativeFilePath).components(separatedBy: "\n")
        let administrativeCode = data["code"] as! String
        let address = data["address_name"] as! String
        
        let targetData = administrativeDataList.first(where: {
            $0.components(separatedBy: ",")[1] == administrativeCode
        })!
        
        let (nx, ny) = (targetData.components(separatedBy: ",")[5], targetData.components(separatedBy: ",")[6])
        return LocationData(nx: nx, ny: ny, address: address)
    }
    
    fileprivate func _getKakaoReverseGeocodingApiUrl(lat: Double, lng: Double) -> String {
        return "\(kakaoReverseGeocodingApiUrl)?x=\(lng)&y=\(lat)"
    }
    
    fileprivate func _getKakaoAuthHeaders() -> HTTPHeaders {
        return ["Authorization": "KakaoAK \(kakaoRestApiKey)"]
    }
    
}
