//
//  WeatherData.swift
//  WeatherForecast
//
//  Created by MAC GNC on 2024/06/03.
//

import Foundation

// 날씨 데이터 모델입니다
class WeatherData {
    var temperature: Double? // 현재 기온 (°C)
    var humidity: Double? // 현재 습도 (%)
    var rainfallPattern = RainfallPattern.none // 강우 패턴
    var precipitation: ClosedRange<Double>? // 1시간 강우/강설량 (mm)
    
    init(data: [[String: Any]]) {
        for item in data {
            switch item["category"] as? String {
                
            case "T1H":
                self.temperature = Double(item["obsrValue"] as! String)
                
            case "REH":
                self.humidity = Double(item["obsrValue"] as! String)
                
            case "PTY":
                switch item["obsrValue"] as! String {
                case "1", "5":
                    self.rainfallPattern = .rain
                case "3", "7":
                    self.rainfallPattern = .snow
                case "2":
                    self.rainfallPattern = .rainAndSnow
                case "4":
                    self.rainfallPattern = .shower
                case "6":
                    self.rainfallPattern = .sleet
                default:
                    self.rainfallPattern = .none
                }
                
            case "RN1":
                switch Double(item["obsrValue"] as! String) ?? -1 {
                case 0..<1:
                    self.precipitation = 0...1
                case 1..<30:
                    self.precipitation = 1...30
                case 30..<50:
                    self.precipitation = 30...50
                case 50..<Double.infinity:
                    self.precipitation = 50...Double.infinity
                default:
                    break
                }
                
            default:
                break
            }
        }
    }
}
