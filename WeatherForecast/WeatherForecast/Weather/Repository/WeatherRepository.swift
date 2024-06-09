//
//  WeatherRepository.swift
//  WeatherForecast
//
//  Created by MAC GNC on 2024/06/03.
//

import Foundation
import Alamofire

fileprivate typealias Json = [String: Any]

// 날씨에 관련된 API 및 데이터 가공과 처리를 합니다
class WeatherRepository {
    
    func fetchWeatherData(nx: String, ny: String, callback: @escaping (WeatherData?) -> Void) {
        let (date, time) = _getCurrentDateTime()
        let apiUrl = _generateWeatherForecastApiUrl(yyyyMmDd: date, hhMm: time, nx: nx, ny:ny)
        
        AF.request(apiUrl).validate(statusCode: 200..<500).response { result in
            if let jsonData = try? JSONSerialization.jsonObject(with: result.data!, options: []) as? Json {
                let response = jsonData["response"] as? Json
                let body = response?["body"] as? Json
                let items = (body?["items"] as? Json)?["item"] as? [Json]
                
                if let _ = items {
                    callback(WeatherData(data: items!))
                }
                else { callback(nil) }
            }
        }
    }
    
    func _getCurrentDateTime() -> (String, String) {
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyyMMdd"
        timeFormatter.dateFormat = "HHmm"
        
        return (dateFormatter.string(from: Date.now), timeFormatter.string(from: Date.now))
    }
    
    func _generateWeatherForecastApiUrl(yyyyMmDd date: String, hhMm time: String, nx: String, ny: String) -> String {
        let serviceKeyParamter = "serviceKey=tcsBNpATjD5aZ1L3W9T37CvfzcQ9fIgyOf7%2B%2B1Q1OEb7hyUcuT%2FOHJ4pVbu8UwqqrKq9IotLZ4gz21gGalza1w%3D%3D"
        
        let dateTimeParameter = "base_date=\(date)&base_time=\(time)"
        
        let nxNyParameter = "&nx=\(nx)&ny=\(ny)"
        
        return "\(weatherForecastApiUrl)?\(serviceKeyParamter)&\(dateTimeParameter)&\(nxNyParameter)&numOfRows=10&pageNo=1&dataType=JSON"
    }
    
}
